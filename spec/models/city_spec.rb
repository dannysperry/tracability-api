require 'rails_helper'

RSpec.describe City, type: :model do
  let(:subject) { build :city }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:name) }
end
