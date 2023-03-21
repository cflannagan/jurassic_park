# Cages is what is supposed to prevent our park from becoming a plot device!
class Cage < ApplicationRecord
  enum power_status: { active: "ACTIVE", down: "DOWN" }

  validates :capacity, :power_status, presence: true
  validates :capacity, numericality: { only_integer: true, greater_than: 0 }

  has_many :dinosaurs

  def down!
    raise StandardError, "cannot power down cage with dinosaurs present" if dinosaurs.present?

    super
  end
end
