require 'open-uri'
require 'nokogiri'
require 'geocoder'

class CinesController < ApplicationController
  
  ##
  # devuelve todos los cines
  #
  def all    
    
    doc = Nokogiri::HTML(open("http://www.bases123.com.ar/eldia/cines/index.php"))
    
    @cines = doc.xpath('//select[@id="cine"]/option').map do |i|
      {:nombre => i.text, :cine_id => i.xpath('@value').text}      
    end    
          
    render :json => @cines
    
  end  
  
  ##
  # Inserta todos los cines y actualiza (from scratch)
  #  
  def insertAll    
    
  #  begin

      # tengo romper la abstraccion porque quiero que empiece el id siempre desde 1
      # si no bastaría con hacer Cine.delete_all
      #ActiveRecord::Base.connection.execute("truncate table #{'cines'}") # no funciono en postgres
      Cine.delete_all
    
      doc = Nokogiri::HTML(open("http://www.bases123.com.ar/eldia/cines/index.php"))
    
      doc.xpath('//select[@id="cine"]/option').map do |info|
        Cine.create(:nombre => info.text, :external_id => info.xpath('@value').text)
      end    
      
      # borro el primer registro porque dice simplemente "+ Cines"
      Cine.find(:first).destroy

      
      @mensaje = "Los cines fueron creados con &eacute;xito!"

#    rescue Exception => exc
       #logger.error("Message for the log file #{exc.message}")
#       @mensaje = "Algo malo pas&oacute; :("
 #   end          
        
    render :text => @mensaje
    
  end  
  
  ##
  # Devuelve los datos de un cine
  #
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

  
  
  ##
  # Dada una coordenada devuelve donde estoy
  #  
  def whereAmI
    
    lat = params[:latitud]
    long = params[:longitud]
    
    @donde = Geocoder.search(lat + "," + long)[0]
    
    render :json => {:direccion => @donde.address }
    
  end
    
end
