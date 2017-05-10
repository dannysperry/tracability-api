require 'rails_helper'

RSpec.describe RoomSection, type: :model do
  let(:subject) { build(:room_section) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:room) }

  it { is_expected.to validate_presence_of(:section_type) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:area_in_inches) }
end