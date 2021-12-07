require 'rails_helper'
require 'faker'

RSpec.describe Appointment, type: :model do
  before(:each) do 
    @owner = User.create(
      email: Faker::Internet.email,
      password: Faker::Internet.password
    )

    @property = Property.create(
      title: Faker::Beer.brand,
      owner: @owner
    )

    @slot = Slot.create(
      property: @property,
      start_date: Faker::Time.between(
        from: DateTime.now + 1,
        to: DateTime.now + 30
      )
    )

    @candidate = User.create(
      email: Faker::Internet.email,
      password: Faker::Internet.password
    )

    @appointment = Appointment.create(
      candidate: @candidate,
      slot: @slot
    )
  end

  context "validations" do
    it "is valid with valid attributes" do
      expect(@appointment).to be_a(Appointment)
      expect(@appointment).to be_valid
    end

    describe "#candidate" do
      it 'should not be valid without candidate' do
        bad_appointment = Appointment.create(slot: @slot)
        expect(bad_appointment).not_to be_valid
        expect(bad_appointment.errors.include?(:candidate)).to eq(true)
      end
    end

    describe '#slot' do
      it 'should not be valid without slot' do
        bad_appointment = Appointment.create(candidate: @candidate)
        expect(bad_appointment).not_to be_valid
        expect(bad_appointment.errors.include?(:slot)).to eq(true)
      end
    end
  end

  context "associations" do
    describe "property" do
      it 'should have a property' do
        expect(@appointment.property == @property).to eq(true)
      end
    end

    describe 'candidate' do
      it 'should have a candidate' do
        expect(@appointment.candidate == @candidate).to eq(true)
      end
    end

    describe 'slot' do
      it 'should have a slot' do
        expect(@appointment.slot == @slot).to eq(true)
      end
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