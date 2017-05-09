class RoomSerializer < ActiveModel::Serializer
  attributes :id, :name, :area_in_inches, :room_type

  has_one :location
end
