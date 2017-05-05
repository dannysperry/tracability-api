class LicenseSerializer < ActiveModel::Serializer
  attributes :id, :license_number, :license_type
  has_one :state
end
