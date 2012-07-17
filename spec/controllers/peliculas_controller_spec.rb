
require 'spec_helper'

describe PeliculasController do
  
  describe "GET #index" do

  	it "assigns the requested Peliculas to @movies and @cartelera" do
    	peliculas = Factory.create(:estreno)
    	get :index
    	assigns(:movies).should eq([peliculas])
  	end
  end

end
  