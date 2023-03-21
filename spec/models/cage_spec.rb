require 'rails_helper'

RSpec.describe Cage, type: :model do
  subject { build(:cage) }
  context "factory" do
    it { is_expected.to be_valid }
  end

  context "enum" do
    subject { create(:cage) }
    it { is_expected.to be_down }
    it "should become active" do
      expect { subject.active! }.to change { subject.power_status }.from("down").to("active")
      expect { subject.down! }.to change { subject.power_status }.from("active").to("down")
    end
  end

  context "associations" do
    it { should have_many(:dinosaurs) }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:capacity) }
    it { should validate_numericality_of(:capacity).only_integer.is_greater_than(0) }
    it { is_expected.to validate_presence_of(:power_status) }
    describe "powered_when_occupied" do
      let!(:dino) { create(:dinosaur, cage:) }
      let(:cage) { create(:cage, :active) }
      it "errors" do
        cage.power_status = "down"
        expect(cage).not_to be_valid
        expect(cage.errors[:base].first).to include("powered on")
      end
    end
    describe "does_not_exceed_capacity" do
      it "errors when exceeding capacity" do
        cage = create(:cage, :active, capacity: 2)
        create(:dinosaur, cage:)
        create(:dinosaur, name: "Another", species: Species.take, cage:)
        expect(cage).to be_full
        cage.capacity = 1
        expect(cage).not_to be_valid
        expect(cage.errors[:base].first).to include("#{cage.dinosaurs.count} or more")
      end
    end
  end

  context "instance methods" do
    before(:each) do
      subject.save!
      subject.active!
    end
    describe "#down!" do
      let!(:dino) { create(:dinosaur, cage: subject) }
      it "disallowed when dinosaurs are present" do
        expect { subject.down! }.to raise_error(StandardError)
        dino.remove_from_cage!
        expect { subject.reload.down! }.not_to raise_error
      end
    end
    describe "#occupied?" do
      it { is_expected.not_to be_occupied }
      it "occupied" do
        create(:dinosaur, cage: subject)
        expect(subject).to be_occupied
      end
    end
    describe "#full?" do
      it { is_expected.not_to be_full }
      it "full" do
        create(:dinosaur, cage: subject)
        expect(subject).to be_full
      end
    end
  end
end
