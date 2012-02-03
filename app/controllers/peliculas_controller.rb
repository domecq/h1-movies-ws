require 'open-uri'
require 'nokogiri'

class PeliculasController < ApplicationController
  
  # Los estrenos de la semana  
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
  
  #  Peliculas en cartelera    
  def cartelera
        
    doc = Nokogiri::HTML(open("http://cartelera.terra.com.ar/carteleracine/"))
    #//*[@id="tabla_en_cartelera"]
    @peliculas = doc.xpath('//div[@id="encartel"]/table/tbody/tr').map do |info|
      
      pelicula_link = info.xpath("td[@class='pelicula']/a/@href").text.split('/').to_a
      # saco el 1 misterioso, para que el id vuelva a la normalidad
      pelicula_id = pelicula_link[pelicula_link.count - 1].chop        
            
      { :titulo => info.xpath('td[@class="pelicula"]/a').text,
        :actores => info.xpath('td[@class="actores"]/a').text, 
        :pelicula_id => pelicula_id,
        :imagen => 'http://www.123info.com.ar/fotos/' + pelicula_id + 'ch.jpg'
        }      
    end    
          
    render :json => @peliculas
    
  end
  
  # Obtengo el detalle de una pelicula
  def get
    
    doc = Nokogiri::HTML(open("http://www.bases123.com.ar/eldia/cines/pelicula.php?id=" + params[:pelicula_id]))
    
    @pelicula = doc.xpath('/html/body/div/table').map do |info|
      { :titulo => info.xpath('tr[1]/td[2]/strong').text, 
        :imagen => info.xpath('tr[1]/td[1]/img/@src').text,
        :descripcion => info.xpath('tr[1]/td[2]/p').text,
        :titulo_original => info.xpath('tr[2]/td/ul/li[1]/span').text,
        :director => info.xpath('tr[2]/td/ul/li[9]/span').text,
        :guionista => info.xpath('tr[2]/td/ul/li[10]/span').text,
        }      
    end    
          
    render :json => @pelicula
      
  end
  
  
  
end
