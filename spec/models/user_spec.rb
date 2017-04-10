RSpec.describe User do
  subject { create :user }
  it { is_expected.to be_valid }
end
