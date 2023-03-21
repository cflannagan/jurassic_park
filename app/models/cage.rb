# Cages is what is supposed to prevent our park from becoming a plot device!
class Cage < ApplicationRecord
  validates :capacity, :power_status, presence: true
end
