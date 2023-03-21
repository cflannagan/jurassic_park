require 'rails_helper'

RSpec.describe Species, type: :model do
  subject { build(:species) }
  context "factory" do
    it { is_expected.to be_valid }
  end

  context "enum" do
    subject { build(:species, :herbivore, name: "A new herbivore species") }
    it { is_expected.to be_herbivore }
    it "should raise an error" do
      subject.save!
      expect { subject.carnivore! }.to raise_error(StandardError)
      expect { subject.herbivore! }.to raise_error(StandardError)
    end
  end

  context "associations" do
    it { should have_many(:dinosaurs) }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:dinosaur_type) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
