require 'spec_helper'

describe Pelicula do 
	# without factory girl
	# before {
	# 	@pelicula = Pelicula.new(
	# 		titulo: "Trapito para los mas chiquitos", 
	# 		descripcion: "Algo de un espantapajaros", 
	# 		brief: "espantapajaros",
	# 		imagen: "bases123.com.ar/fotos/cine/4766.jpg", 
	# 		imagen_chica: "bases123.com.ar/fotos/cine/4766.jpg"
	# 		)
	# }
	# subject { @pelicula }
	# it { respond_to(:titulo)}
	# it { respond_to(:descripcion)}
	# it { respond_to(:brief)}
	# it { respond_to(:imagen)}	
	# it { respond_to(:imagen_chica)}		
	# it { should be_valid }
	# describe "when titulo is not present" do
	# 	before {@pelicula.titulo = " "}
	# 	it {should_not be_valid}
	# end

	it "has a valid factory" do
		Factory.create(:pelicula).should be_valid
	end

	it "is invalid without a titulo" do
  		Factory.build(:pelicula, titulo: nil).should_not be_valid
	end
	
	it "is valid with a titulo" do
  		Factory.create(:pelicula, titulo: 'Trapito para los mas chiquitos').should be_valid
	end

end