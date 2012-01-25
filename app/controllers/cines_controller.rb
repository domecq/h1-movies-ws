require 'open-uri'
require 'nokogiri'

class CinesController < ApplicationController
  
  def all    
    
    doc = Nokogiri::HTML(open("http://www.bases123.com.ar/eldia/cines/index.php"))
    
    @cines = doc.xpath('//select[@id="cine"]/option').map do |i|
      {:nombre => i.text, :id => i.xpath('@value').text}      
    end    
          
    render :json => @cines
    
  end  
  
  def show
    doc = Nokogiri::HTML(open("http://www.bases123.com.ar/eldia/cines/cine.php?id=" + params[:id]))
    
  end
  
  
end
