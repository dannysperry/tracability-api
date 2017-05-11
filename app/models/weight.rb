class Weight < ApplicationRecord
  belongs_to :weighable, polymorphic: true

  validates_associated :weighable, on: :update

  enum amount_type: { mcg: 0, mg: 1, g: 2, kg: 3, ton: 4  }
  enum weight_type: { base: 0, adjustment: 1 }

  validates_presence_of :amount
end
