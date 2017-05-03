class CitySerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :state
end
