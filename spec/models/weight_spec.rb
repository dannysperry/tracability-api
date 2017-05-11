require 'rails_helper'

RSpec.describe Weight, type: :model do
  let(:subject) { build(:weight) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:weighable) }
  it { is_expected.to validate_presence_of(:amount) }
end
