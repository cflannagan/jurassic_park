require 'rails_helper'

RSpec.describe Cage, type: :model do
  subject { build(:cage) }
  context "factory" do
    it { is_expected.to be_valid }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:capacity) }
    it { should validate_numericality_of(:capacity).only_integer.is_greater_than(0) }
    it { is_expected.to validate_presence_of(:power_status) }
  end
end
