require 'rails_helper'

RSpec.describe Regulation, type: :model do
  let(:subject) { build(:regulation) }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:legal_reference_code) }
end
