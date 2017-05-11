require 'active_support/concern'

module Weighable
  extend ActiveSupport::Concern

  included do
    has_many :weights, as: :weighable

    attribute :weight_amount, :integer
    attribute :weight_amount_type, :integer
    attribute :weight_type, :integer

    after_save do
      errors.add(:weight, "Needs one weight") unless self.weights.count <= 1

      if (weight_amount.present? and weight_amount_type.present? and weight_type.present?) || self.weights.count > 1
        self.weights.create(amount: weight_amount, amount_type: weight_amount_type, weight_type: weight_type)
      end
    end
  end
end