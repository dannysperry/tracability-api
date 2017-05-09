require 'rails_helper'

RSpec.describe GrowingStage, type: :model do
  let(:subject) { build(:growing_stage) }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to belong_to(:license) }
end
