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

2.times do |count|
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "user#{count}-immolib@yopmail.com",
    password: "userpwd"
    )
    puts "User with id #{user.id} created"
end

# admin
admin = User.create(
  first_name: 'Admin',
  last_name: 'istrateur',
  email: "immolib-admin@yopmail.com",
  password: "adminpwd",
  is_admin: true,
)
puts "Admin with id #{admin.id} created"

# properties

2.times do
  property = Property.create!(
    owner_project: "rent",
    title: Faker::DcComics.title,
    city: Faker::Address.city,
    other_link: "https://www.pap.fr/",
    instructions: Faker::Lorem.sentence(word_count: 50 + rand(1..100)),
    is_paid: Faker::Boolean.boolean(true_ratio: 0.8),
    owner: User.all.sample
    )
    puts "Property with id #{property.id} created"
end

# slots

duration = [15, 30, 45, 60]

2.times do
  slot = Slot.create!(
    property: Property.all.sample,
    start_date: DateTime.now + 1,
    duration: duration.sample,
    max_appointments: rand(1..10)
    )
    puts "Slot with id #{slot.id} created"
end

5.times do
  slot = Slot.create!(
    property: Property.all.sample,
    start_date: Faker::Time.between(from: DateTime.now + 2, to: DateTime.now + 15),
    duration: duration.sample,
    max_appointments: rand(1..10)
    )
    puts "Slot with id #{slot.id} created"
end

# appointments

2.times do

  # to avoid owner = candidate
  owner = User.all.sample
  candidate = User.all.sample

  while owner == candidate
    candidate = User.all.sample
  end

  appointment = Appointment.create!(
    candidate: candidate,
    slot: Slot.all.sample,
    candidate_message: Faker::Lorem.paragraph_by_chars(number: 50 + rand(1..200))
    )
    puts "Appointment with id #{appointment.id} created"
end

