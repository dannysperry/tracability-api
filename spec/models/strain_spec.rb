require 'rails_helper'

RSpec.describe Strain, type: :model do
  let(:subject) { build(:strain) }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to validate_numericality_of(:expected_potency) }
  it { is_expected.to validate_numericality_of(:expected_yield) }
  it { is_expected.to validate_numericality_of(:veg_days) }
  it { is_expected.to validate_numericality_of(:flower_days) }
end
