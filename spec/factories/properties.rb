require 'faker'

FactoryBot.define do
  factory :property do
    title { Faker::Beer.brand }
    owner { FactoryBot.create(:user) }
  end
end
