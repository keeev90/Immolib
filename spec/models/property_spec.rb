require 'rails_helper'
require 'faker'

RSpec.describe Property, type: :model do
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
      expect(@property).to be_a(Property)
      expect(@property).to be_valid
    end

    describe "#title" do
      it 'should not be valid without title' do
        bad_property = Property.create(owner: @owner)
        expect(bad_property).not_to be_valid
        expect(bad_property.errors.include?(:title)).to eq(true)
      end

      it 'should have at least 3 characters' do
        bad_property = Property.create(owner: @owner, title: 'a')
        expect(bad_property).not_to be_valid
        expect(bad_property.errors.include?(:title)).to eq(true)
      end

      it 'should have at most 140 characters' do
        bad_property = Property.create(owner: @owner, title: 'a' * 200)
        expect(bad_property).not_to be_valid
        expect(bad_property.errors.include?(:title)).to eq(true)
      end
    end

    describe '#owner' do
      it 'should not be valid without owner' do
        bad_property = Property.create(title: Faker::Beer.brand)
        expect(bad_property).not_to be_valid
        expect(bad_property.errors.include?(:owner)).to eq(true)
      end
    end
  end

  context "associations" do
    describe "properties" do
      it 'should have a owner' do
        expect(@property.owner == @owner).to eq(true)
      end

      it 'should have many slots' do
        expect(@property.slots.include?(@slot)).to eq(true)
      end

      it 'should have many appointments' do
        expect(@property.appointments.include?(@appointment)).to eq(true)
      end

      it 'should have many candidates' do
        expect(@property.candidates.include?(@candidate)).to eq(true)
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