# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# SPECIES

# carnivores
%i[Tyrannosaurus Velociraptor Spinosaurus Megalosaurus].each do |carnivore|
  Species.find_or_create_by!(name: carnivore, dinosaur_type: "carnivore")
  puts "Seeded #{carnivore} species"
end

# herbivores
%i[Brachiosaurus Stegosaurus Ankylosaurus Triceratops].each do |herbivore|
  Species.find_or_create_by!(name: herbivore, dinosaur_type: "herbivore")
  puts "Seeded #{herbivore} species"
end

# CAGES
[2, 3, 4, 5].each do |capacity|
  Cage.find_or_create_by!(capacity:)
  puts "Cage with capacity of #{capacity} added to Jurassic Park!"
end

# DINOSAURS
dinosaurs = [
  {"Ty" => :Tyrannosaurus},
  {"Roberta" => :Tyrannosaurus},

  # Blue's Pack
  {"Blue" => :Velociraptor},
  {"Charlie" => :Velociraptor},
  {"Delta" => :Velociraptor},
  {"Echo" => :Velociraptor},

  {"Spiny" => :Spinosaurus},
  {"Mega" => :Megalosaurus},
  {"Brachy" => :Brachiosaurus},
  {"Rocky" => :Stegosaurus},
  {"Tank" => :Ankylosaurus},
  {"Trixie" => :Triceratops},
]
dinosaurs.each do |dinosaur|
  name, species_name = dinosaur.first
  species = Species.find_by(name: species_name)
  Dinosaur.find_or_create_by!(name:, species:)
  puts "#{name}, a #{species_name}, has been added to Jurassic Park!"
end

ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end
