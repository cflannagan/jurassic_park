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
  end

  context "powering down" do
    let(:cage) do
      subject.save!
      subject.active!
      subject
    end
    let!(:dino) { create(:dinosaur, cage:) }
    it "disallowed when dinosaurs are present" do
      expect { cage.down! }.to raise_error(StandardError)
      dino.remove_from_cage!
      expect { cage.reload.down! }.not_to raise_error
    end
  end
end
