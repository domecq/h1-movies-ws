require 'open-uri'
require 'nokogiri'

class PeliculasController < ApplicationController
  
  def estrenos

    doc = Nokogiri::HTML(open("http://www.123info.com.ar/cine/index.php"))
    
    @movies = doc.xpath('//div[@id="tresc"]/ul/li').map do |i|
      {:title => i.xpath('strong/a').text}      
    end    
    render :json => @movies
    
  end    
  
  def cartelera
  end
  
end
