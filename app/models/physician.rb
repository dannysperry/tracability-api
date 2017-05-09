class Physician < ApplicationRecord
  has_many :patients

  validates_presence_of :name, :license_number
  validates_uniqueness_of :license_number
end
