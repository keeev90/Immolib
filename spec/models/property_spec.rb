require 'rails_helper'
require 'faker'

RSpec.describe Property, type: :model do
  before(:each) do
    @property = FactoryBot.create(:property)
  end

  context "validations" do
    it "is valid with valid attributes" do
      expect(@property).to be_a(Property)
      expect(@property).to be_valid
    end

    describe "#title" do
      it { expect(@property).to validate_presence_of(:title) }

      it {
        expect(@property).to validate_length_of(:title)
          .is_at_least(3)
          .is_at_most(140)
      }
    end

    describe '#owner' do
      it { expect(@property).to validate_presence_of(:owner) }
    end
  end

  context "associations" do
    describe "owner" do
      it { expect(@property).to belong_to(:owner) }
    end

    describe 'slots' do
      it { expect(@property).to have_many(:slots) }
    end

    describe 'appointments' do
      it { expect(@property).to have_many(:appointments) }
    end

    describe 'candidates' do
      it { expect(@property).to have_many(:candidates) }
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