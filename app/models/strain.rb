class Strain < ApplicationRecord
  validates :name, presence: true

  validates_numericality_of :expected_potency, :expected_yield, :veg_days, :flower_days
end
