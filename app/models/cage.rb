# Cages is what is supposed to prevent our park from becoming a plot device!
class Cage < ApplicationRecord
  enum power_status: { active: "ACTIVE", down: "DOWN" }

  validates :capacity, :power_status, presence: true
  validates :capacity, numericality: { only_integer: true, greater_than: 0 }
  validate :powered_when_occupied, if: :occupied?
  validate :does_not_exceed_capacity, if: :occupied?

  has_many :dinosaurs

  def self.empty
    left_joins(:dinosaurs).where(dinosaurs: { id: nil })
  end

  def self.full
    left_joins(:dinosaurs).group(:id).having('count(dinosaurs.id) >= cages.capacity')
  end

  # includes empty
  def self.not_full
    left_joins(:dinosaurs).group(:id).having('count(dinosaurs.id) < cages.capacity')
  end

  # includes full
  def self.not_empty
    joins(:dinosaurs)
  end

  def down!
    raise StandardError, "cannot power down cage with dinosaurs present" if dinosaurs.present?

    super
  end

  # We have a db constraint that will ensure, even with race conditions, we don't see dinosaurs.count actually exceed
  # capacity in persisted state.
  def full?
    dinosaurs.count >= capacity
  end

  def occupied?
    dinosaurs.exists?
  end

  private

  def does_not_exceed_capacity
    errors.add(:base, "Capacity must be #{dinosaurs.count} or more!") if dinosaurs.count > capacity
  end

  def powered_when_occupied
    errors.add(:base, "Cage must be powered on when holding dinosaurs!") if down?
  end
end
