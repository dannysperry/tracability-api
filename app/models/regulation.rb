class Regulation < ApplicationRecord
  validates :legal_reference_code, presence: true
end
