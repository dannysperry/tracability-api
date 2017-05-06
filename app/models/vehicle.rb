class Vehicle < ApplicationRecord
  belongs_to :license

  validates_presence_of :make, :model, :year, :color
  validates_numericality_of :year, greater_than: 1900, less_than: 2100, only_integer: true
end
