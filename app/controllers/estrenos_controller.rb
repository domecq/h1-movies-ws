require 'nokogiri'
require 'open-uri'

class EstrenosController < ApplicationController
  
  def index    
    doc = Nokogiri::XML(open("http://www.123info.com.ar/cine/index.php"))
    @links = doc.xpath('//div[@id="tres"]/ul').map do |i|
      {'title' => i.xpath('li/strong').inner_text}      
    end    
  end
    
end
