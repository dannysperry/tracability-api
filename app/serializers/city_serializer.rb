class CitySerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :state
  has_many :patients
end
