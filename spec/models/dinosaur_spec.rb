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

  context "delegates" do
    it { is_expected.to be_carnivore }
    it "herbivore" do
      herbivore_species = build(:species, :herbivore)
      subject.species = herbivore_species
      expect(subject).to be_herbivore
    end
  end

  context "instance methods" do
    describe "#caged?" do
      it { is_expected.not_to be_caged }
      it { is_expected.to be_not_caged }
      it "caged" do
        subject.cage = build(:cage)
        expect(subject).to be_caged
        expect(subject).not_to be_not_caged
      end
    end
  end
end
