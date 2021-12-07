require 'rails_helper'
require 'faker'

RSpec.describe User, type: :model do
  before(:each) do 
    @user = FactoryBot.create(:user)
  end

  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  context "validations" do
    it "is valid with valid attributes" do
      expect(@user).to be_a(User)
      expect(@user).to be_valid
    end

    describe "#email" do
      it { expect(@user).to validate_presence_of(:email) }

      it 'should be a valid email address' do
        bad_user = FactoryBot.build(:user, email: 'coucou')
        expect(bad_user).not_to be_valid
        expect(bad_user.errors.include?(:email)).to eq(true)
      end
    end

    describe '#password' do
      it { expect(@user).to validate_length_of(:password).is_at_least(6) }
    end

    describe User do
      it { should validate_presence_of(:password) }
    end
  end

  context "associations" do
    describe "properties" do
      it { expect(@user).to have_many(:properties) }
    end

    describe 'appointments' do
      it { expect(@user).to have_many(:appointments) }
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
