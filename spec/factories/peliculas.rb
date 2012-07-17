FactoryGirl.define do
	factory :pelicula, aliases: [:estreno] do |f|
	  f.titulo  "Mingo y anibal contra los fantasmas"
	  f.descripcion "Una de las mejores fs del cine nacional despues de monguito"
	  f.brief  "Una peli de minguito"
	  f.imagen  "bases123.com.ar/fotos/cine/4766.jpg"
	  f.imagen_chica "bases123.com.ar/fotos/cine/4766ch.jpg"
	  f.es_estreno true	  
	end

	factory :cartelera, class: Pelicula do |f|

	  f.titulo  "Trapito para los mas chiquitos"
	  f.descripcion "Algo de garcia ferre"
	  f.brief  "espantapajaros"
	  f.imagen  "bases123.com.ar/fotos/cine/4766.jpg"
	  f.imagen_chica "bases123.com.ar/fotos/cine/4766ch.jpg"
	  f.es_estreno false

	end

end