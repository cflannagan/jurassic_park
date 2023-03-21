require 'rails_helper'

RSpec.describe Species, type: :model do
  subject { build(:species) }
  context "factory" do
    it { is_expected.to be_valid }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:dinosaur_type) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
