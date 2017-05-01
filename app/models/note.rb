class Note < ApplicationRecord
  belongs_to :notable, polymorphic: true, optional: true

  validates_presence_of :name
end
