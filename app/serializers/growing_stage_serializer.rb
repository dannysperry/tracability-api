class GrowingStageSerializer < ActiveModel::Serializer
  attributes :id, :name, :description

  has_one :license
end
