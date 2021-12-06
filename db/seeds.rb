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

5.times do |count|
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "user#{count}@yopmail.com",
    password: "userpwd"
    )
    puts "User with id #{user.id} created"
end

# properties

2.times do
  property = Property.create!(
    title: Faker::DcComics.title,
    city: Faker::Address.city,
    other_link: "https://www.pap.fr/",
    instructions: Faker::Lorem.sentence(word_count: 50 + rand(1..100)),
    owner: User.all.sample
    )
    puts "Property with id #{property.id} created"
end

# slots

duration = [15, 30, 45, 60]

10.times do
  slot = Slot.create!(
    property: Property.all.sample,
    start_date: Faker::Time.between(from: DateTime.now + 1, to: DateTime.now + 30),
    duration: duration.sample,
    max_appointments: rand(1..10)
    )
    puts "Slot with id #{slot.id} created"
end

# appointments

5.times do
  appointment = Appointment.create!(
    candidate: User.all.sample,
    slot: Slot.all.sample
    )
    puts "Appointment with id #{appointment.id} created"
end

