require 'open-uri'
require 'nokogiri'

class PeliculasController < ApplicationController
  
  # Los estrenos de la semana  
  def estrenos

    @movies = Pelicula.where(:es_estreno => true).select('id, titulo, brief, imagen')
    render :json => @movies
    
  end    
  
  def estrenosEstatico
    @movies = [{"pelicula_id" =>"4579","titulo" => "Chac\u00fa","brief" => "Documental realizado por un grupo de investigadores chaque\u00f1os bajo la direcci\u00f3n del historiador Felipe Pigna, que intenta retratar la historia de...\u00a0","imagen" => "http://www.123info.com.ar/fotos/4579ch.jpg"},{"pelicula_id" => "4571","titulo" => "La dama de hierro","brief" => "Cuenta la historia de la ex Primer Ministra Brit\u00e1nica Margaret Thatcher, una mujer que atraves\u00f3 todas las barreras de g\u00e9nero y clase para ser...\u00a0","imagen" => "http://www.123info.com.ar/fotos/4571ch.jpg"},{"pelicula_id" => "4578","titulo" => "Los descendientes","brief" => "En Hawai, Matt, un hombre casado y padre de dos ni\u00f1as, debe reevaluar su pasado y navegar su futuro cuando su esposa queda en coma luego de un...\u00a0","imagen" => "http://www.123info.com.ar/fotos/4578ch.jpg"},{"pelicula_id"=>"4574","titulo"=>"Moacir","brief"=>"Documental sobre Moacir Dos Santos un cantante, compositor y bailar\u00edn de carnaval brasile\u00f1o que nunca tuvo la posibilidad de demostrar su talento....\u00a0","imagen"=>"http://www.123info.com.ar/fotos/4574ch.jpg"},{"pelicula_id"=>"4575","titulo"=>"Que lo pague la noche","brief"=>"Buenos Aires, Diciembre del 2001. Esteche celebra su boda en una plaza de Villa Lugano. Inesperadamente en el momento del brindis cae desmayado sobre...\u00a0","imagen"=>"http://www.123info.com.ar/fotos/4575ch.jpg"},{"pelicula_id"=>"4577","titulo"=>"Selkirk, el verdadero Robinson Crusoe","brief"=>"Alexander Selkirk, un pirata rebelde y ego\u00edsta, es el piloto del Esperanza, un gale\u00f3n ingl\u00e9s que surca los mares del sur en busca de tesoros. A...\u00a0","imagen"=>"http://www.123info.com.ar/fotos/4577ch.jpg"},{"pelicula_id"=>"4568","titulo"=>"The chemical brothers: Don`t think","brief"=>"Por casi dos d\u00e9cadas, el espect\u00e1culo audiovisual de The Chemical Brothers se ha presentado en conciertos y festivales alrededor del mundo, pero...\u00a0","imagen"=>"http://www.123info.com.ar/fotos/4568ch.jpg"},{"pelicula_id"=>"4572","titulo"=>"Viaje 2: La isla misteriosa","brief"=>"Sean Anderson de 17 a\u00f1os, recibe una se\u00f1al codificada de auxilio desde una misteriosa isla. Como no puede impedir que Sean rastree la se\u00f1al hasta...\u00a0","imagen"=>"http://www.123info.com.ar/fotos/4572ch.jpg"},{"pelicula_id"=>"4573","titulo"=>"Viaje 2: La isla misteriosa 3D","brief"=>"Sean Anderson de 17 a\u00f1os, recibe una se\u00f1al codificada de auxilio desde una misteriosa isla. Como no puede impedir que Sean rastree la se\u00f1al hasta...\u00a0","imagen"=>"http://www.123info.com.ar/fotos/4573ch.jpg"}]
    render :json => @movies
  end
  
  
  #  Peliculas en cartelera    
  def cartelera
        
    @peliculas = Pelicula.find(:all, :select => ['id','titulo','descripcion','interpretes','imagen'])
    render :json => @peliculas
    
  end
  
  def get
  end
  
  ##
  # Inserto todas las peliculas
  def insertAll
    
    Pelicula.delete_all
        
    doc = Nokogiri::HTML(open("http://cartelera.terra.com.ar/carteleracine/"))
    #//*[@id="tabla_en_cartelera"]
    doc.xpath('//div[@id="encartel"]/table/tbody/tr').map do |info|
      
      pelicula_link = info.xpath("td[@class='pelicula']/a/@href").text.split('/').to_a
      # saco el 1 misterioso, para que el id vuelva a la normalidad
      pelicula_id = pelicula_link[pelicula_link.count - 1].chop        
            
      Pelicula.create(:titulo => info.xpath('td[@class="pelicula"]/a').text,
        :external_id => pelicula_id,
        :imagen => 'http://www.123info.com.ar/fotos/' + pelicula_id + 'ch.jpg')  
        
    end    
    
    # Argrego el detalle de cada pelicula
    peliculas = Pelicula.all  
    peliculas.each do |pelicula|
      
      doc = Nokogiri::HTML(open("http://www.bases123.com.ar/eldia/cines/pelicula.php?id=" + pelicula.external_id.to_s))
      
      doc.xpath('/html/body/div/table').map do |info|
        
        p = Pelicula.find(pelicula.id)
        
        p.attributes = { 
          :imagen => info.xpath('tr[1]/td[1]/img/@src').text,
          :descripcion => info.xpath('tr[1]/td[2]/p').text.gsub(/\[ Donde verla \]/,''),
          :titulo_original => info.xpath('tr[2]/td/ul/li[1]/span').text,
          :pais => info.xpath('tr[2]/td/ul/li[2]/span').text,        
          :anio => info.xpath('tr[2]/td/ul/li[3]/span').text,        
          :duracion => info.xpath('tr[2]/td/ul/li[4]/span').text,
          :calificacion => info.xpath('tr[2]/td/ul/li[5]/span').text,        
          :estreno => info.xpath('tr[2]/td/ul/li[6]/span').text,                
          :web => info.xpath('tr[2]/td/ul/li[7]/span').text,                        
          :genero => info.xpath('tr[2]/td/ul/li[8]/span').text,
          :interpretes => info.xpath('tr[2]/td/ul/li[9]/span').text,          
          :director => info.xpath('tr[2]/td/ul/li[10]/span').text,
          :guionista => info.xpath('tr[2]/td/ul/li[11]/span').text,
          :fotografia => info.xpath('tr[2]/td/ul/li[12]/span').text,        
          :musica => info.xpath('tr[2]/td/ul/li[13]/span').text,        
          }    
          p.save  
      end    
      
      
    end
    
    @mensaje = 'Las pel&iacute;culas fueron creadas con &eacute;xito!'
    render :text => @mensaje
    
  end
  ##
  # Inserto los estrenos
  def insertEstrenos

    doc = Nokogiri::HTML(open("http://www.bases123.com.ar/eldia/cines/index.php"))
    
    doc.xpath('/html/body/div/table/tr').map do |i|
      titulo = i.xpath('td/strong/a').text
      brief = i.xpath('td[@class="texto"]').text.gsub(/\[ver m\u00e1s\]|\n/,'').strip.sub(titulo,'')
      link = i.xpath('td/a/@href').text.split('=').to_a
      pelicula_id = link[1]
      
      Pelicula.create(:external_id => pelicula_id,
        :titulo => titulo, 
        :brief => brief,
        :imagen => i.xpath('td/img/@src').text,
        :es_estreno => true
        )
    end    
    @mensaje = 'Los estrenos fueron creados con &eacute;xito!'
    render :text => @mensaje
    
  end    
  
  
  # Obtengo el detalle de una pelicula (remotamente)
  def getFromAway
    
    doc = Nokogiri::HTML(open("http://www.bases123.com.ar/eldia/cines/pelicula.php?id=" + params[:pelicula_id]))
    
    
    @pelicula = doc.xpath('/html/body/div/table').map do |info|
      { :titulo => info.xpath('tr[1]/td[2]/strong').text, 
        :imagen => info.xpath('tr[1]/td[1]/img/@src').text,
        :descripcion => info.xpath('tr[1]/td[2]/p').text.gsub(/\[ Donde verla \]/,''),
        :titulo_original => info.xpath('tr[2]/td/ul/li[1]/span').text,
        :pais => info.xpath('tr[2]/td/ul/li[2]/span').text,        
        :anio => info.xpath('tr[2]/td/ul/li[3]/span').text,        
        :duracion => info.xpath('tr[2]/td/ul/li[4]/span').text,
        :calificacion => info.xpath('tr[2]/td/ul/li[5]/span').text,        
        :estreno => info.xpath('tr[2]/td/ul/li[6]/span').text,                
        :web => info.xpath('tr[2]/td/ul/li[7]/span').text,                        
        :genero => info.xpath('tr[2]/td/ul/li[8]/span').text,
        :interpretes => info.xpath('tr[2]/td/ul/li[9]/span').text,          
        :director => info.xpath('tr[2]/td/ul/li[10]/span').text,
        :guionista => info.xpath('tr[2]/td/ul/li[11]/span').text,
        :fotografia => info.xpath('tr[2]/td/ul/li[12]/span').text,        
        :musica => info.xpath('tr[2]/td/ul/li[13]/span').text,        
        }      
    end    
          
    render :json => @pelicula
      
  end
  
  
  
end
