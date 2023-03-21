require 'rails_helper'

RSpec.describe Dinosaur, type: :model do
  subject { build(:dinosaur, species: build(:species, :herbivore)) }
  context "factory" do
    it { is_expected.to be_valid }
  end

  context "associations" do
    it { should belong_to(:species).without_validating_presence }
    it { should belong_to(:cage).optional }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    describe "cage was assigned" do
      let(:cage) { create(:cage, :down) }
      let!(:dino) { create(:dinosaur, cage: nil) }
      it "powered down" do
        dino.cage = cage
        expect(dino).not_to be_valid
        expect(dino.errors[:base].first).to include("powered down")
      end
      it "full" do
        dino.cage = cage
        cage.active!
        create(:dinosaur, name: "FasterThanYou!", species: dino.species, cage:)
        expect(dino).not_to be_valid
        expect(dino.errors[:base].first).to include("full")
      end
      it "carnivores can only be assigned to cages with same species" do
        uncaged_carnivore = create(
          :dinosaur,
          name: "Mr. Teeth",
          species: create(:species, :carnivore, name: "Many Teeth")
        )
        cage.update!(capacity: 2)
        cage.active!
        create(
          :dinosaur,
          name: "Not Friends with Mr. Teeth",
          species: create(:species, :carnivore, name: "Even More Teeth"),
          cage:
        )
        uncaged_carnivore.cage = cage
        expect(uncaged_carnivore).not_to be_valid
        expect(uncaged_carnivore.errors[:base].first).to include("containing #{uncaged_carnivore.species}")
      end
      it "herbivores can only be assigned to cages with no carnivores" do
        uncaged_herbivore = create(
          :dinosaur,
          name: "Mr. Gummy",
          species: create(:species, :herbivore, name: "Gummy Teeth")
        )
        cage.update!(capacity: 2)
        cage.active!
        create(
          :dinosaur,
          name: "Please That Herbivore To My Cage",
          species: create(:species, :carnivore, name: "Many Teeth"),
          cage:
        )
        uncaged_herbivore.cage = cage
        expect(uncaged_herbivore).not_to be_valid
        expect(uncaged_herbivore.errors[:base].first).to include("containing other herbivores")
      end
    end
  end

  context "delegates" do
    it { is_expected.to be_herbivore }
    it "carnivore" do
      carnivore_species = build(:species, :carnivore)
      subject.species = carnivore_species
      expect(subject).to be_carnivore
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
