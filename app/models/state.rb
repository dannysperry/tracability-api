class State < ApplicationRecord
  validates :name, presence: true
  validates :abbreviation, presence: true, length: { is: 2 }

  has_many :cities
  has_many :licenses
end
