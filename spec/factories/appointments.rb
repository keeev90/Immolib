require 'faker'

FactoryBot.define do
  factory :appointment do
    candidate { FactoryBot.create(:user) }
    slot { FactoryBot.create(:slot) }
  end
end
