require 'rails_helper'

RSpec.describe License, type: :model do
  let(:subject) { build(:license) }

  it { is_expected.to be_valid }
  it { is_expected.to belong_to(:state) }
  it { is_expected.to validate_presence_of(:license_type) }
  it { is_expected.to validate_presence_of(:license_number) }
  it { is_expected.to validate_uniqueness_of(:license_number) }
end
