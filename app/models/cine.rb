class Cine < ActiveRecord::Base
  belongs_to :zona
  has_and_belongs_to_many :peliculas  
end
