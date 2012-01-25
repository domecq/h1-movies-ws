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
  
  def get
    doc = Nokogiri::HTML(open("http://www.bases123.com.ar/eldia/cines/cine.php?id=" + params[:cine_id]))
    
    @cine = doc.xpath('/html/body/div/p[1]').map do |info|
        data_cine = info.text.lines
        {:nombre => data_cine.to_a[1], :direccion => data_cine.to_a[2], :localidad => data_cine.to_a[3]}
    end
    
    doc = Nokogiri::HTML(open("http://cartelera.terra.com.ar/carteleracine/sala/" + params[:cine_id] + "1") )

    #@horarios = doc.xpath("//a[starts-with(@href,'pelicula.php')]/@href").map do |info|
    @peliculas = doc.xpath("//div[@id='filmyhorarios']/ul/li").map do |info|
        horarios = info.xpath("div[@class='horario fleft']").text
        horarios = horarios.gsub(/\t|\n/, '\1')
        { :pelicula => info.xpath("div[@class='film fleft']/h3/a").text,
          :puntos => info.xpath("div[@class='puntos fleft']/span").text,
          :horarios => horarios
          }
    end
    
    render :json => @peliculas
    
  end
  
  
end
