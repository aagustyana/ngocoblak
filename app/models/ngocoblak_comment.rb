 

class NgocoblakComment < ActiveRecord::Base
  attr_accessor :link
  before_save :check_link
  
  def generate_permalink(kind="tinyurl")   
    clnt = HTTPClient.new
    if kind == "bitly"
      rs = clnt.get("http://api.bit.ly/shorten?version=2.0.1&longUrl=#{self.link}&login=bitlyapidemo&apiKey=R_0da49e0a9118ff35f52f629d2d71bf07")
      rs = JSON.parse(rs.content)
      self.update_attribute(:permalink,rs["results"][self.link]["shortUrl"])
    else  
      res = clnt.get("http://tinyurl.com/api-create.php?url=#{self.link}")
      self.update_attribute(:permalink,res.content.gsub(" ","")) if self.permalink.nil?    
    end    
  end
  
  private
  def check_link
    
  end  
end
