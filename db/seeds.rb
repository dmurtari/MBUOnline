# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

case Rails.env
when 'development' || 'test'
  User.create!(firstname: "MBU",
               lastname: "Admin",
               email: "mbu@apo-gammatheta.org",
               password: "letmein",
               password_confirmation: "letmein",
               phone: "123-456-7890",
               admin: true)

  10.times do |course|
    name = Faker::App.name
    price = 15
    room = "TBA"

    Course.create!(name: name,
                   price: price,
                   room: room)
  end
    
end