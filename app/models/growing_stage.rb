class GrowingStage < ApplicationRecord
  belongs_to :license

  validates :name, presence: true
end
