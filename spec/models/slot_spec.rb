require 'rails_helper'
require 'faker'

RSpec.describe Slot, type: :model do
  before(:each) do 
    @slot = FactoryBot.create(:slot)
  end

  context "validations" do
    it "is valid with valid attributes" do
      expect(@slot).to be_a(Slot)
      expect(@slot).to be_valid
    end

    describe "#start_date" do
      it { expect(@slot).to validate_presence_of(:start_date) }

      it 'should not be in the past' do
        bad_slot = FactoryBot.build(:slot, start_date: DateTime.now - 1)
        expect(bad_slot).not_to be_valid
        expect(bad_slot.errors.include?(:start_date)).to eq(true)
      end
    end

    describe '#property' do
      it { expect(@slot).to validate_presence_of(:property) }
    end
  end

  context "associations" do
    describe "property" do
      it { expect(@slot).to belong_to(:property) }
    end

    describe 'appointments' do
      it { expect(@slot).to have_many(:appointments) }
    end

    describe 'candidates' do
      it { expect(@slot).to have_many(:candidates) }
    end
  end

  context "callbacks" do
    describe "some callbacks" do
      # teste ce callback
    end
  end

  context "public instance methods" do
    describe "#some_method" do
      # teste cette méthode
    end
  end

  context "public class methods" do
    describe "self.some_method" do
      # teste cette méthode
    end
  end
end