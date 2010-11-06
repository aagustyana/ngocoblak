
class Feed < ActiveRecord::Base
  has_many :items
  before_create :grab_title_and_price
  
  def grab_title_and_price
    require "rexml/document"

    clnt = HTTPClient.new
    
    res = clnt.get(self.url.gsub(" ",""))
    body = res.content
    body.gsub!("g:price","theprice")

    feed = SimpleRSS.parse(body,true,false)

    for theitem in feed.items
      self.items << Item.new(:price => theitem.theprice,:title => theitem.title,:link => theitem.link)
    end
 
  end  
end
