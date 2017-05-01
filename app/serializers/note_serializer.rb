class NoteSerializer < ActiveModel::Serializer
  attributes :id, :description, :name

  has_one :notable
end
