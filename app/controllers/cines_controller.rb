require 'open-uri'
require 'nokogiri'
require 'geocoder'

class CinesController < ApplicationController
  
  ##
  # devuelve todos los cines
  #
  def all    
    
    @cines = Cine.find(:all, :select => ["nombre","id"])    
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
      Horario.delete_all
    
      doc = Nokogiri::HTML(open("http://www.bases123.com.ar/eldia/cines/index.php"))
    
      doc.xpath('//select[@id="cine"]/option').map do |info|
        Cine.create(:nombre => info.text, :external_id => info.xpath('@value').text)
      end    
      
      # borro el primer registro porque dice simplemente "+ Cines"
      Cine.find(:first).destroy

      # Para cada cine que cree actualizo su información
      @cines = Cine.all      
      @cines.each do |cine|

        # obtengo los datos del cine
        doc = Nokogiri::HTML(open("http://www.bases123.com.ar/eldia/cines/cine.php?id=" + cine.external_id.to_s))

        doc.xpath('/html/body/div/p[1]').map do |info|
            data_cine = info.text.lines
            dir = data_cine.to_a[2].gsub(/\n/,'')
            loc = data_cine.to_a[3].gsub(/\n/,'')
            c = Cine.find(cine.id)
            c.attributes = 
            {
              :direccion => dir, 
              :localidad => loc,
              :address => dir + ', ' + loc.gsub(/\|/,', '), 
            }
            c.save
        end
        
        # obtengo las peliculas que se proyectan en el cine y sus horario
        # nota: el 1 misterioso que se agrega es porque los ids del sitio terra son los mismos que infojet pero con la diferencia 
        # que llevan conctenado un 1 al final
        doc = Nokogiri::HTML(open("http://cartelera.terra.com.ar/carteleracine/sala/" + cine.external_id.to_s + "1") )

        #@horarios = doc.xpath("//a[starts-with(@href,'pelicula.php')]/@href").map do |info|
        doc.xpath("//div[@id='filmyhorarios']/ul/li").map do |info|
          
            horarios = info.xpath("div[@class='horario fleft']").text.gsub(/\t|\n/, '')
            pelicula_link = info.xpath("div[@class='film fleft']/h3/a/@href").text.split('/').to_a
            # saco el 1 misterioso, para que el id vuelva a la normalidad
            pelicula_id = pelicula_link[pelicula_link.count - 1].chop    
            @p = Pelicula.where(:external_id => pelicula_id).first
            logger.debug "Peli: " + @p.class.to_s
            Horario.create(:cine_id => cine.id, :pelicula_id => @p.id, :horas => horarios )

            
        end        
        
      end      

      
      @mensaje = "Los cines fueron creados y actualizados con &eacute;xito!"


      

#    rescue Exception => exc
#       logger.error("Message for the log file #{exc.message}")
#       @mensaje = "Algo malo pas&oacute; :("
#    end          
    render :text => @mensaje
    
  end
  
  def updateShowtimes  

    # Para cada cine que cree actualizo su información
    Horario.delete_all
    @cines = Cine.all      
    @cines.each do |cine|
      
      # obtengo las peliculas que se proyectan en el cine y sus horario
      # nota: el 1 misterioso que se agrega es porque los ids del sitio terra son los mismos que infojet pero con la diferencia 
      # que llevan conctenado un 1 al final
      doc = Nokogiri::HTML(open("http://cartelera.terra.com.ar/carteleracine/sala/" + cine.external_id.to_s + "1") )

      #@horarios = doc.xpath("//a[starts-with(@href,'pelicula.php')]/@href").map do |info|
      doc.xpath("//div[@id='filmyhorarios']/ul/li").map do |info|
        
          horarios = info.xpath("div[@class='horario fleft']").text.gsub(/\t|\n/, '')
          pelicula_link = info.xpath("div[@class='film fleft']/h3/a/@href").text.split('/').to_a
          # saco el 1 misterioso, para que el id vuelva a la normalidad
          pelicula_id = pelicula_link[pelicula_link.count - 1].chop    
          @p = Pelicula.where(:external_id => pelicula_id).first
          logger.debug "Peli: " + @p.class.to_s
          Horario.create(:cine_id => cine.id, :pelicula_id => @p.id, :horas => horarios )

          
      end        
      
    end      

    
    @mensaje = "Los cines fueron actualizados con &eacute;xito!"
    
    render :text => @mensaje
  end
  
  
  ##
  # Devuelve los datos de un cine
  def get
    @cine = Cine.find(params[:cine_id], :select => ["nombre","id","direccion","localidad"])
    render :json => [ @cine, :peliculas =>  @cine.peliculas.select('titulo,horas,pelicula_id')  ]
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
  
  ##
  # Dada una coordenada me devuelve los cines cercanos
  #    
  def findNear
    if params[:latitud].to_s != "" && params[:longitud].to_s != ""
      @cines = Cine.near(params[:latitud].to_s  + "," + params[:longitud].to_s, 10, :order => "distance")    
    else
      @cines = Cine.all
    render :json => @cines    
    
  end
  
    
end
