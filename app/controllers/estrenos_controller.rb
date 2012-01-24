require 'nokogiri'
require 'open-uri'
require 'geocoder'

class EstrenosController < ApplicationController
  
  def index    
    
    doc = Nokogiri::HTML(open("http://www.123info.com.ar/cine/index.php"))
    
    @movies = doc.xpath('//div[@id="tresc"]/ul/li').map do |i|
      {:title => i.xpath('strong/a').text}      
    end    
    
  end
    
end
