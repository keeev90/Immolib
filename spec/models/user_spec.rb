require 'rails_helper'
require 'faker'

RSpec.describe User, type :model do
  before(:each) do 
    @user = User.create(
      email: Faker::Internet.email,
      password: Faker::Internet.password
    )
  end

  context "validations" do
    it "is valid with valid attributes" do
      expect(@user).to be_a(User)
      expect(@user).to be_valid
    end

    describe "#email" do
      it 'should not be valid without email' do
        bad_user = User.create(password: Faker::Internet.password)
        expect(bad_user).not_to be_valid
        expect(bad_user.errors.include?(:email)).to eq(true)
      end

      it 'should be a valid email address' do
        bad_user = User.create(
          email: 'coucou',
          password: Faker::Internet.password
        )
        expect(bad_user).not_to be_valid
        expect(bad_user.errors.include?(:email)).to eq(true)
      end
    end

    describe '#password' do
      it 'should not be valid without password' do
        bad_user = User.create(email: Faker::Internet.email)
        expect(bad_user).not_to be_valid
        expect(bad_user.errors.include?(:password)).to eq(true)
      end

      it 'should be bigger than 6 characters' do
        bad_user = User.create(password: '12345')
        expect(bad_user).not_to be_valid
        expect(bad_user.errors.include?(:password)).to eq(true)
      end
    end
  end

  context "associations" do
    describe "properties" do
      it 'should have many properties' do
        property = Property.create(owner: @user)
        expect(@user.properties.include?(property)).to eq(true)
      end

      it 'should have many appointments' do
        owner = User.create(
          email: Faker::Internet.email,
          password: Faker::Internet.password
        )
        property = Property.create(owner: owner)
        slot = Slot.create(property: property)
        appointment = Appointment.create(candidate: @user, )
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