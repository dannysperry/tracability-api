class VehicleSerializer < ActiveModel::Serializer
  attributes :id, :vin, :make, :model, :year, :color
  has_one :license
end
