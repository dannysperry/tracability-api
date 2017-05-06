require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  let(:subject) { build(:vehicle) }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:make) }
  it { is_expected.to validate_presence_of(:model) }
  it { is_expected.to validate_presence_of(:year) }
  it { is_expected.to validate_presence_of(:color) }

  it "should validate length" do
    vehicle = create(:vehicle)
    expect(vehicle).to validate_numericality_of(:year).is_greater_than(1900).is_less_than(2100).only_integer
  end
end
