class Room < ApplicationRecord
  belongs_to :location
  has_many :room_sections

  enum room_type: { office: 0, inventory: 1, additive: 2, mother: 3, seedling: 4, clone: 5, veg: 6, pre_flower: 7, flower: 8, harvest: 9  }

  validates_presence_of :room_type, :name, :area_in_inches
end
