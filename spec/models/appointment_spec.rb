require 'rails_helper'
require 'faker'

RSpec.describe Appointment, type: :model do
  before(:each) do 
    @appointment = FactoryBot.create(:appointment)
  end

  context "validations" do
    it "is valid with valid attributes" do
      expect(@appointment).to be_a(Appointment)
      expect(@appointment).to be_valid
    end

    describe "#candidate" do
      it { expect(@appointment).to validate_presence_of(:candidate) }
    end

    describe '#slot' do
      it { expect(@appointment).to validate_presence_of(:slot) }
    end
  end

  context "associations" do
    describe "property" do
      it { expect(@appointment).to have_one(:property) }
    end

    describe 'candidate' do
      it { expect(@appointment).to belong_to(:candidate) }
    end

    describe 'slot' do
      it { expect(@appointment).to belong_to(:slot) }
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