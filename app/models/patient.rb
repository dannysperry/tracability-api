class Patient < ApplicationRecord
  belongs_to :physician
  belongs_to :city

  validates_presence_of :name, :street_address
  validates_inclusion_of :is_medical,
                         in: [true, false]
end
