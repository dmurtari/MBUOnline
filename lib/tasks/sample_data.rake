namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    99.times do |n|
      firstname  = Faker::Name::first_name
      lastname = Faker::Name::last_name
      phone = "123-456-7890"
      email = "example-#{n+1}@mbu.org"
      password  = "password"
      User.create!(firstname: firstname,
                   lastname: lastname,
                   phone: phone,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end