class License < ApplicationRecord
  belongs_to :state

  enum license_type: {producer: 0, processor: 1, retailer: 2}

  validates :license_number,
    presence: true,
    uniqueness: true

  validates :license_type,
    presence: true

  has_many :vehicles
end
