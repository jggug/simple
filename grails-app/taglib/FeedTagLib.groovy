import com.sun.syndication.feed.synd.SyndFeed
import com.sun.syndication.io.SyndFeedInput
import com.sun.syndication.io.XmlReader
import java.text.SimpleDateFormat

class FeedTagLib {
  static namespace = 'f'

  def feed={attrs,body ->
    URL feedUrl=new URL(attrs.url)
    def input = new SyndFeedInput()
    def feed = input.build(new XmlReader(feedUrl))
    out << body(feed:feed)
  }
  
  def dateFormat={attrs,body ->
    def sdf=new SimpleDateFormat(attrs.format?:"yyyy/MM/dd")
    out << sdf.format(attrs.date)
  }
}
