require 'rails_helper'

RSpec.describe Physician, type: :model do
  let(:subject) { build(:physician) }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:license_number) }
  it { is_expected.to validate_uniqueness_of(:license_number) }

  it { is_expected.to have_many(:patients) }
end
