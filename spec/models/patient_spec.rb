require 'rails_helper'

RSpec.describe Patient, type: :model do
  let(:subject) { build(:patient) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:physician) }
  it { is_expected.to belong_to(:city) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:street_address) }

  let(:subject) { create(:patient) }
end
