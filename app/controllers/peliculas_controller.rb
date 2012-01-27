require 'open-uri'
require 'nokogiri'

class PeliculasController < ApplicationController
  
  def estrenos

    doc = Nokogiri::HTML(open("http://www.bases123.com.ar/eldia/cines/index.php"))
    
    @movies = doc.xpath('/html/body/div/table/tr').map do |i|
      titulo = i.xpath('td/strong/a').text
      brief = i.xpath('td[@class="texto"]').text.gsub(/\[ver m\u00e1s\]|\n/,'').strip.sub(titulo,'')
      link = i.xpath('td/a/@href').text.split('=').to_a
      pelicula_id = link[1]
      
      { :pelicula_id => pelicula_id,
        :titulo => titulo, 
        :brief => brief,
        :imagen => i.xpath('td/img/@src').text,
        }
    end    
    render :json => @movies
    
  end    
    
  def cartelera
    
    doc = Nokogiri::HTML(open("http://www.bases123.com.ar/eldia/cines/index.php"))
    
    @peliculas = doc.xpath('//select[@id="pelicula"]/option').map do |i|
      {:nombre => i.text, :id => i.xpath('@value').text}      
    end    
          
    render :json => @peliculas
    
  end
  
  
end
