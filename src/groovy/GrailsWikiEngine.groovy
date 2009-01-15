//package org.grails.wiki
import org.codehaus.groovy.control.CompilerConfiguration

import org.radeox.engine.BaseRenderEngine
import org.radeox.api.engine.WikiRenderEngine
//import org.grails.wiki.WikiPage
import org.radeox.macro.BaseMacro
import org.radeox.macro.parameter.MacroParameter
import org.radeox.filter.regex.RegexTokenFilter

import org.radeox.filter.context.FilterContext
import org.radeox.regex.MatchResult
import org.radeox.filter.FilterPipe
import org.radeox.filter.regex.RegexFilter
import org.radeox.filter.MacroFilter
import org.radeox.macro.MacroLoader
import org.radeox.api.engine.context.InitialRenderContext
import org.radeox.filter.*
import org.radeox.util.Encoder
import org.springframework.beans.BeanWrapperImpl
import java.lang.reflect.Field

/**
* @author Graeme Rocher
* @since 1.0
*
* Created: Feb 19, 2008
*/
class GrailsWikiEngine extends BaseRenderEngine implements WikiRenderEngine{

    static CONTEXT_PATH = "contextPath"
    static CACHE = "cache"

    public GrailsWikiEngine(InitialRenderContext initialRenderContext) {
        super(initialRenderContext);
    }

    public GrailsWikiEngine() {
        super();
    }




    protected void init() {
      if (null == fp) {
          FilterPipe localFP = new FilterPipe(initialContext);
          

            def filters = [
                            ParamFilter,
                            MacroFilter,
                            TextileLinkFilter,
                            HeaderFilter,
                            ListFilter,
                            TableFilter,
                            LineFilter,
                            StrikeThroughFilter,
                            NewlineFilter,
                            ParagraphFilter,
                            BoldFilter,
                            CodeFilter,
                            ItalicFilter,
                            LinkTestFilter,
                            ImageFilter,
                            MarkFilter,
                            KeyFilter,
                            TypographyFilter,
                            EscapeFilter
                            ]

            for(f in filters) {
                RegexFilter filter = f.newInstance()
                localFP.addFilter(filter)

                if(filter instanceof MacroFilter) {
                    MacroLoader loader = new MacroLoader()
                    def repository = filter.getMacroRepository()
                    loader.add(repository, new WarningMacro())
                    loader.add(repository, new NoteMacro())
                    loader.add(repository, new InfoMacro())
                    loader.add(repository, new AnchorMacro())
                    //GroovyMacro
                    loader.add(repository, new GroovyMacro())
                }
            }
            localFP.init();
            setFilterPipe localFP

        }
    }

    void setFilterPipe(FilterPipe filterPipe) {
        Field field = getClass().getSuperclass().getDeclaredField("fp")
        field.setAccessible true
        field.set(this, filterPipe)
    }

    
    public boolean exists(String name) {
        if(name.startsWith('#')) {
            // its an anchor link
            return true
        }
        else if(name.startsWith("http:")||name.startsWith("https:") || name.startsWith("mailto:")) {
            return true
        }
        else {
            def cache = initialContext.get(CACHE)
            if(cache?.getWikiText(name)) return true
        
            if(name.indexOf("#")>-1) {
                name = name[0..name.indexOf('#')-1]
            }
        
            def page = Page.findByTitle(name)
        
            return page != null
        }
    }

    public boolean showCreate() {
        return true;
    }

    public void appendLink(StringBuffer buffer, String name, String view, String anchor) {
        def contextPath = initialContext.get(CONTEXT_PATH)
        contextPath = contextPath ?: ""
        if(name.startsWith("http:")||name.startsWith("https:"))
            buffer <<  "<a href=\"$name#$anchor\" class=\"pageLink\">$view</a>"
        else
            buffer <<  "<a href=\"$contextPath/$name#$anchor\" class=\"pageLink\">$view</a>"
    }

    public void appendLink(StringBuffer buffer, String name, String view) {

        def contextPath = initialContext.get(CONTEXT_PATH)
        contextPath = contextPath ?: ""
        def decoded = URLDecoder.decode(name, 'utf-8')

        int i =decoded.indexOf('#')
        if(decoded.startsWith('#')) {
            buffer <<  "<a href=\"${decoded}\" class=\"pageLink\">${decoded[1..-1]}</a>"
        }
        else if(i>-1) {
            appendLink(buffer,URLEncoder.encode(decoded[0..i-1],'utf-8'),view, decoded[i+1..-1])            
        }
        else {

            if(decoded.startsWith("http:")||decoded.startsWith("https:") || decoded.startsWith("mailto:"))
                buffer <<  "<a href=\"$decoded\" class=\"pageLink\">$view</a>"
            else
                buffer <<  "<a href=\"$contextPath/$name\" class=\"pageLink\">$view</a>"
        }

    }

    public void appendCreateLink(StringBuffer buffer, String name, String view) {
        def contextPath = initialContext.get(CONTEXT_PATH)
        contextPath = contextPath ?: "."
        
        buffer <<  "<a href=\"$contextPath/create/$name\" class=\"createPageLink\">$view +</a>"
    }

}

public class WarningMacro extends BaseMacro {
    String getName() {"warning"}
    void execute(Writer writer, MacroParameter params) {
    writer << '<blockquote class="warning">' << params.content << "</blockquote>"
  }
}
public class NoteMacro extends BaseMacro {
    String getName() {"note"}
    void execute(Writer writer, MacroParameter params) {
    writer << '<blockquote class="note">' << params.content << "</blockquote>"
  }
}

public class InfoMacro extends BaseMacro {
    String getName() {"info"}
    void execute(Writer writer, MacroParameter params) {
    writer << '<blockquote class="info">' << params.content << "</blockquote>"
  }
}
public class AnchorMacro extends BaseMacro {

    String getName() { "anchor" }

    void execute(Writer writer, MacroParameter params) {
        if(params.length >0) {
            def name = params.get(0)
            def body = params.content ?: ''
            writer << "<a name=\"$name\">${body}</a>"
        }
    }

}

public class GroovyMacro extends BaseMacro {
    String getName() {"groovy"}
    void execute(Writer writer, MacroParameter params) {
      
      if(params.content){
        StringWriter out = new StringWriter();
        StringWriter err = new StringWriter();
        PrintWriter stdout = new PrintWriter(out);
        PrintWriter stderr = new PrintWriter(err);

        CompilerConfiguration cc = new CompilerConfiguration();
        cc.setOutput(stdout)
        cc.setSourceEncoding("utf-8");

        def b = new Binding();
        b.setVariable("out",stdout)
        b.setVariable("err",stderr)
        def shell = new GroovyShell(Thread.currentThread().getContextClassLoader(),b,cc)
        def script = params.content.replaceAll("&#62;",">")
        def result = ""
        try {
          Script parse = shell.parse(script)
          parse.run()
          stdout.flush()
          result = out.toString()
        } catch(Exception e) {
          result = "<b>ERROR</b> ${e}"
        } finally {
          out.close()
          err.close()
          stdout.close()
          stderr.close()
        }
        writer << "<pre>"
        writer << result
        writer << "</pre>"
        writer << '<pre class="groovy">' << params.content << "</pre>"
      }else{
        writer <<""
      }
  }
}


class ItalicFilter extends RegexTokenFilter {
    public ItalicFilter() {
        super(/\s_([^\n]*?)_\s/);
    }
    public void handleMatch(StringBuffer buffer, MatchResult result, FilterContext context) {
        buffer << " <em class=\"italic\">${result.group(1)}</em> "
    }
}
class BoldFilter extends RegexTokenFilter {
    public BoldFilter() {
        super(/\*([^\n]*?)\*/);
    }
    public void handleMatch(StringBuffer buffer, MatchResult result, FilterContext context) {
        buffer << "<strong class=\"bold\">${result.group(1)}</strong>"
    }
}
class CodeFilter extends RegexTokenFilter {

    public CodeFilter() {
        super(/\s@([^\n]*?)@\s/);
    }


    public void handleMatch(StringBuffer buffer, MatchResult result, FilterContext context) {
		def text = result.group(1)
		// are we inside a code block?
		if(text.indexOf('class="code"') > -1) buffer << "@$text@"
		else buffer << "<code>${text}</code>"
    }
}
class ImageFilter  extends RegexTokenFilter {
    public ImageFilter() {
        super(/!(\S*?)!/);
    }


    public void handleMatch(StringBuffer buffer, MatchResult result, FilterContext context) {

        def img = result.group(1)
        def path = context.renderContext.get(GrailsWikiEngine.CONTEXT_PATH) ?: "."
                    

        def image = img.startsWith("http:") ? img :  "$path/images/$img"

        buffer << "<img border=\"0\" class=\"center\" src=\"$image\"></img>"
    }
}
class LinkTestFilter extends RegexTokenFilter {


    public LinkTestFilter() {
        super(/\[(.*?)\]/)
    }

    
    public void handleMatch(StringBuffer buffer, MatchResult matchResult, FilterContext filterContext) {
        def engine = filterContext.getRenderContext().getRenderEngine()

        
        if(engine instanceof WikiRenderEngine) {
            GrailsWikiEngine wikiEngine = engine


            try {
                String name = matchResult.group(1)

                int pipeIndex = name.indexOf('|');
                String alias = name;
                if (-1 != pipeIndex) {
                    alias = name.substring(0, pipeIndex);
                    name = name.substring(pipeIndex + 1);
                }

                def link = name.startsWith("http:") ? name : java.net.URLEncoder.encode(name,'utf-8')

                if(wikiEngine.exists(name) || (link.startsWith("http:")||link.startsWith("https:")))
                    wikiEngine.appendLink(buffer, link, alias)
                else {
                    wikiEngine.appendCreateLink(buffer, link, alias)
                }
            }
            catch(Exception e) {
                println e.message
                e.printStackTrace()
            }
        }
    }

}
class TextileLinkFilter extends RegexTokenFilter {

    public TextileLinkFilter() {
        super(/"([^"]+?)":(\S+?)(\s)/);
    }


    public void handleMatch(StringBuffer buffer, MatchResult result, FilterContext context) {
        def text = result.group(1)
        def link = result.group(2)
        def space = result.group(3)

        if(link.startsWith("http://")) {
            buffer << "<a href=\"$link\" target=\"blank\">$text</a>$space"
        }
        else {
            buffer << "<a href=\"$link\">$text</a>$space"
        }
    }
}
class HeaderFilter extends RegexTokenFilter{

    public HeaderFilter() {
        super(/(?m)^h(\d)\.\s+?(.*?)$/);
    }


    public void handleMatch(StringBuffer out, MatchResult matchResult, FilterContext filterContext) {

          def header = matchResult.group(1)
          def content = matchResult.group(2)
          def contentNoTags = content?.replaceAll(/(m?)<\/?[^>]+>/,'')

          out << "<h$header>$content</h$header><a name=\"$contentNoTags\"></a>"
    }


}
class TableFilter extends RegexTokenFilter {

    public TableFilter() {
        super(/(?m)^(\|(.|\n)+\|\n[^\|])/)
    }

    public void handleMatch(StringBuffer stringBuffer, MatchResult matchResult, FilterContext filterContext) {
        def result = matchResult.group(1)
        def colCount = 0
        result.eachLine{
           def current = it.trim()
           if(current.startsWith("||")) {
               if(colCount==0) stringBuffer << '<table class="wikiTable">'
               stringBuffer << '<tr class="wikiHeaderRow">'
               def tokens = current.split(/\|\|/)
               for(t in tokens ) {
                   if(t!="") stringBuffer << "<th class='wikiRowTh'>${t}</th>"
               }
               stringBuffer << '</tr>'
               colCount++
           }
           else if(current.startsWith("|")) {
               if(colCount==0) stringBuffer << '<table class="wikiTable">'
               def tokens = current.split(/\|/)
               stringBuffer << '<tr class="wikiRow">'
               for(t in tokens ) {
                   if(t!="") stringBuffer << "<td class='wikiRowTd'>${t}</td>"
               }
               stringBuffer << '</tr>'
               colCount++
           }
           
           if(!current.startsWith("|")){
               colCount=0
               stringBuffer << '</table>'
               stringBuffer << "$it\n"
           }
        }
        stringBuffer << '</table>'

    }


}