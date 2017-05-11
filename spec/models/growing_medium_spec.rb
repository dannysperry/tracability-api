require 'rails_helper'

RSpec.describe GrowingMedium, type: :model do
  let!(:subject) { create :growing_medium }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:medium_type) }
  it { is_expected.to validate_presence_of(:barcode) }
  it { is_expected.to validate_presence_of(:quantity) }

  it { is_expected.to have_many(:weights) }
end
