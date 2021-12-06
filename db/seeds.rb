# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Faker::Config.locale = 'fr'

User.destroy_all
Property.destroy_all
Slot.destroy_all
Appointment.destroy_all

# users

count = 0

5.times do
  count += 1
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = "user#{count}@yopmail.com"

  User.create!(
    first_name: first_name,
    last_name: last_name,
    email: email,
    password: "userpwd"
    )
end

# properties

2.times do
  Property.create!(
    title: Faker::DcComics.title,
    city: Faker::Address.city,
    other_link: "https://www.pap.fr/",
    instructions: Faker::Lorem.sentence(word_count: 50 + rand(1..100)),
    owner_id: User.all.sample.id
    )
end

# slots

duration = [15, 30, 45, 60]

10.times do
  Slot.create!(
    property_id: Property.all.sample.id,
    start_date: Faker::Time.between(from: DateTime.now + 1, to: DateTime.now + 30),
    duration: duration.sample,
    max_appointments: rand(1..10)
    )
end

# appointments

5.times do
  Appointment.create!(
    candidate_id: User.all.sample.id,
    slot_id: Slot.all.sample.id
    )
end

