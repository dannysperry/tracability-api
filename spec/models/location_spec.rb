require 'rails_helper'

RSpec.describe Location, type: :model do
  let(:subject) { build(:location) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:license) }
  it { is_expected.to belong_to(:city) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:street_address) }
  it { is_expected.to validate_presence_of(:area_in_inches) }
end
