class String  
  def between(before,after)
    rs1 = self.split(before)
    if rs1.size > 1
      rs2 = rs1[1].split(after)  
      return rs2[0] if rs2.size > 1        
    end  
    #return self
  end  
end

puts "blaaba url:http://adityakircon.blogsome.com ".between("url:","")