require 'rails_helper'

RSpec.describe Note, type: :model do
  let(:subject) { build(:note) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:notable) }
  it { is_expected.to validate_presence_of(:name) }
end
