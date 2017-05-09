require 'rails_helper'

RSpec.describe Room, type: :model do
  let(:subject) { build(:room) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:location) }

  it { is_expected.to validate_presence_of(:room_type) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_inclusion_of(:is_growing_space).in_array([true, false]) }
  it { is_expected.to validate_presence_of(:area_in_inches) }
end
