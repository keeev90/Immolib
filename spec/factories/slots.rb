FactoryBot.define do
  factory :slot do
    property { FactoryBot.create(:property) }
    start_date { Faker::Time.between(
      from: DateTime.now + 1,
      to: DateTime.now + 30
    ) }
    duration { 15 * rand(1..12) }
    max_appointments { rand(1..100000) }
  end
end
