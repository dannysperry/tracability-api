class PatientSerializer < ActiveModel::Serializer
  attributes :id, :name, :street_address, :is_medical

  has_one :physician
  has_one :city
end
