# Dinosaurs are what keep our Jurassic Park profit machine running!
class Dinosaur < ApplicationRecord
  belongs_to :species
  belongs_to :cage, optional: true

  validates :name, presence: true, uniqueness: true
  with_options if: :cage do |cage|
    cage.validate :cage_is_not_powered_down
    cage.validate :cage_is_not_full
    cage.validate :cage_has_same_species
    cage.validate :cage_has_no_carnivores
  end

  delegate :carnivore?, :herbivore?, to: :species

  def self.caged
    where.not(cage_id: nil)
  end

  def self.not_caged
    where(cage_id: nil)
  end

  def self.by_species_name(species_name)
    joins(:species).where(species: { name: species_name })
  end

  def self.carnivore
    joins(:species).where(species: { dinosaur_type: "carnivore" })
  end

  # No "carnivore" counterpart, we would need to use "by_species_name" instead
  def self.herbivore
    joins(:species).where(species: { dinosaur_type: "herbivore" })
  end

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

  private

  def cage_is_not_powered_down
    errors.add(:base, "Cannot assign to powered down cage") if cage.down?
  end

  def cage_is_not_full
    errors.add(:base, "Cannot assign to full cage") if cage.full?
  end

  def cage_has_same_species
    return unless carnivore?

    return unless cage.dinosaurs.where.not(species:).exists?

    errors.add(:base, "#{name} is a #{species}; can only be assigned to either an active empty cage or a cage " \
      "containing #{species} dinosaurs")
  end

  def cage_has_no_carnivores
    return unless herbivore?

    return unless cage.dinosaurs.joins(:species).where("species.dinosaur_type = 'carnivore'").exists?

    errors.add(:base, "#{name} is a #{species} (a herbivore); can only be assigned to either an active empty cage or a
      cage containing other herbivores")
  end
end
