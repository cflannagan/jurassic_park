# Dinosaurs are what keep our Jurassic Park profit machine running!
class Dinosaur < ApplicationRecord
  belongs_to :species
  belongs_to :cage, optional: true

  validates :name, presence: true, uniqueness: true

  delegate :carnivore?, :herbivore?, to: :species

  def caged?
    cage.present?
  end

  def not_caged?
    !caged?
  end

  # won't error if already removed from cage
  def remove_from_cage!
    update!(cage: nil)
  end
end
