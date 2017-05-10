class GrowingMediumSerializer < ActiveModel::Serializer
  attributes :id, :name, :medium_type, :barcode, :quantity

  has_one :room_section
end
