class RoomSection < ApplicationRecord
  belongs_to :room
  has_many :growing_media

  enum section_type: { grow: 0, harvest: 1, inventory: 2 }

  validates_presence_of :name, :area_in_inches, :section_type
end
