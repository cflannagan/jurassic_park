require 'rails_helper'

RSpec.describe Dinosaur, type: :model do
  subject { build(:dinosaur) }
  context "factory" do
    it { is_expected.to be_valid }
  end

  context "associations" do
    it { should belong_to(:species) }
    it { should belong_to(:cage).optional }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
