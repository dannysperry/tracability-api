class GrowingMedium < ApplicationRecord
  belongs_to :room_section

  enum medium_type: { hydro: 0, soil: 1, soilless: 2 }

  validates_presence_of :name, :barcode, :medium_type, :quantity
end
