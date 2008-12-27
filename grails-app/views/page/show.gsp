

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>${page.title}</title>
    </head>
    <body>
      <div class="body-block">
            <g:if test="${page.page}">
              <div style="background-color:#EDF;padding:3px;">
              <g:link controller="page" action="show" 
                id="${page.page.id}">${page.page.title?.encodeAsHTML()}</g:link>&nbsp;>&nbsp;<g:link controller="page" action="show" 
                id="${page.id}">${page.title?.encodeAsHTML()}</g:link>
              </div>
            </g:if>


            <div style="font-size:10px;color:#666666; text-align:right;width:100%;margin:10 0 10 0;padding:3 0 10 0;border-top:1px dashed #CCC">
              作成日<g:formatDate format="yyyy-MM-dd HH:mm:ss" date="${page.dateCreated}"/>/
              更新日<g:formatDate format="yyyy-MM-dd HH:mm:ss" date="${page.lastUpdated}"/>
            </div>


            <div class="wiki-content" style="width:100%;margin:15px 0 20px 0;">
              <!--${page?.body}-->
              <w:show>
                ${page?.body}
              </w:show>
            </div>
            
            


            <div style="width:100%;margin:10 0 10 0;padding:10 0 1 0;border-bottom:2px solid #3C78B5">
              子ページ <g:link controller="page" params="['page.id':page?.id]" action="create">追加</g:link>
            </div>
            <g:if test="${page.pages.size()>0}">
            <div style="width:100%;border:1px solid #ccc">
              <ul style="margin-top:5px">
              <g:each var="p" in="${page.pages}">
                  <li><g:link controller="page" action="show" id="${p.id}">${p.title?.encodeAsHTML()}</g:link></li>
              </g:each>
              </ul>
            </div>
            </g:if>
      </div>
    </body>
</html>
