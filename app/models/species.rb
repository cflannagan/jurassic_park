# Species of dinosaurs. Can either be carnivore or herbivore.
class Species < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :dinosaur_type, presence: true
end
