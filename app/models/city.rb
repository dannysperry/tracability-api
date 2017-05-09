class City < ApplicationRecord
  belongs_to :state
  has_many :patients

  validates :name, presence: true
end
