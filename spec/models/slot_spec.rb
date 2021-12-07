require 'rails_helper'
require 'faker'

RSpec.describe Slot, type: :model do
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
      expect(@slot).to be_a(Slot)
      expect(@slot).to be_valid
    end

    describe "#start_date" do
      it 'should not be valid without start_date' do
        bad_slot = Slot.create(property: @property)
        expect(bad_slot).not_to be_valid
        expect(bad_slot.errors.include?(:start_date)).to eq(true)
      end

      it 'should not be in the past' do
        bad_slot = Slot.create(
          property: @property,
          start_date: DateTime.now - 1
        )
        expect(bad_slot).not_to be_valid
        expect(bad_slot.errors.include?(:start_date)).to eq(true)
      end
    end

    describe '#property' do
      it 'should not be valid without property' do
        bad_slot = Slot.create(start_date: DateTime.now + 1)
        expect(bad_slot).not_to be_valid
        expect(bad_slot.errors.include?(:property)).to eq(true)
      end
    end
  end

  context "associations" do
    describe "property" do
      it 'should have a property' do
        expect(@slot.property == @property).to eq(true)
      end
    end

    describe 'appointments' do
      it 'should have many appointments' do
        expect(@slot.appointments.include?(@appointment)).to eq(true)
      end
    end

    describe 'candidates' do
      it 'should have many candidates' do
        expect(@slot.candidates.include?(@candidate)).to eq(true)
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