# Species of dinosaurs. Can either be carnivore or herbivore.
class Species < ApplicationRecord
  enum dinosaur_type: { carnivore: "carnivore", herbivore: "herbivore" }

  validates :name, presence: true, uniqueness: true
  validates :dinosaur_type, presence: true

  has_many :dinosaurs

  def to_s
    name
  end

  def carnivore!
    raise StandardError, "Changing dinosaur type is not allowed"
  end

  def herbivore!
    raise StandardError, "Changing dinosaur type is not allowed"
  end
end
