class Cine < ActiveRecord::Base
  belongs_to :zona
  has_many :horarios  
  has_many :peliculas, :through => :horarios

  geocoded_by :address
  after_validation :geocode  
end
