FactoryBot.define do
  factory :slot do
    property { FactoryBot.create(:property) }
    start_date { Faker::Time.between(
      from: DateTime.now + 1,
      to: DateTime.now + 30
    ) }
  end
end
