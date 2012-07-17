class Pelicula < ActiveRecord::Base
  has_many :horarios
  has_many :cines, :through => :horarios

  validates :titulo, presence: true
end
