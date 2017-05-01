require 'rails_helper'

RSpec.describe InventoryType, type: :model do
  let(:subject) { build(:inventory_type) }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:name) }
end
