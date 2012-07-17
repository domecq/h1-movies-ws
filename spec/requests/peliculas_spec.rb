require 'spec_helper'

describe "Peliculas" do

  # test /peliculas
  describe "list peliculas" do

    
  	before {pelicula = FactoryGirl.create(:pelicula, :titulo => "Trapito")}

    it "should have content movie list" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/peliculas'
      #response.status.should be(200)
      #page.should have_content()
      page.should have_content("Trapito")

    end
  end


end
