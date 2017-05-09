class Location < ApplicationRecord
  belongs_to :license
  belongs_to :city

  has_many :rooms

  validates_presence_of :name, :street_address, :area_in_inches
end
