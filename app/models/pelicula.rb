class Pelicula < ActiveRecord::Base
  has_many :cines, :through => :horarios
end
