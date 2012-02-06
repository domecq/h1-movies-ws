require 'open-uri'
require 'nokogiri'

class CinesController < ApplicationController
  
  def all    
    
    doc = Nokogiri::HTML(open("http://www.bases123.com.ar/eldia/cines/index.php"))
    
    @cines = doc.xpath('//select[@id="cine"]/option').map do |i|
      {:nombre => i.text, :cine_id => i.xpath('@value').text}      
    end    
          
    render :json => @cines
    
  end  
  
  def get
    
    # obtengo los datos del cine
    doc = Nokogiri::HTML(open("http://www.bases123.com.ar/eldia/cines/cine.php?id=" + params[:cine_id]))
    
    @cine = doc.xpath('/html/body/div/p[1]').map do |info|
        data_cine = info.text.lines
        {:nombre => data_cine.to_a[1].gsub(/\n/,''), 
          :direccion => data_cine.to_a[2].gsub(/\n/,''), 
          :localidad => data_cine.to_a[3].gsub(/\n/,'')
          }
    end
    
    # obtengo las peliculas que se proyectan en el cine y sus horario
    # nota: el 1 misterioso que se agrega es porque los ids del sitio terra son los mismos que infojet pero con la diferencia 
    # que llevan conctenado un 1 al final
    doc = Nokogiri::HTML(open("http://cartelera.terra.com.ar/carteleracine/sala/" + params[:cine_id] + "1") )

    #@horarios = doc.xpath("//a[starts-with(@href,'pelicula.php')]/@href").map do |info|
    @peliculas = doc.xpath("//div[@id='filmyhorarios']/ul/li").map do |info|
        horarios = info.xpath("div[@class='horario fleft']").text.gsub(/\t|\n/, '')
        pelicula_link = info.xpath("div[@class='film fleft']/h3/a/@href").text.split('/').to_a
        # saco el 1 misterioso, para que el id vuelva a la normalidad
        pelicula_id = pelicula_link[pelicula_link.count - 1].chop        
        { :pelicula => info.xpath("div[@class='film fleft']/h3/a").text,
          :pelicula_id => pelicula_id,
          :puntos => info.xpath("div[@class='puntos fleft']/span").text,
          :horarios => horarios
          }
    end
    
    # agrego las peliculas/horarios al cine
    @cine[0][:peliculas] = @peliculas
    
    # render
    render :json => @cine
    
  end

end
