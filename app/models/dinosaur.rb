# Dinosaurs are what keep our Jurassic Park profit machine running!
class Dinosaur < ApplicationRecord
  belongs_to :species
  belongs_to :cage, optional: true

  validates :name, presence: true, uniqueness: true
end
