class Horario < ActiveRecord::Base
  belongs_to :cine
  belongs_to :pelicula
end
