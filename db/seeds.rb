# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Request.destroy_all

REQUESTS_TO_CREATE = 1000

REQUESTS_TO_CREATE.times do
  name = Faker::StarWars.character
  email = name.gsub(" ", '_') + "@gmail.com"
  department = ["Sales", "Technical", "Marketing"].sample
  message = Faker::Hipster.paragraph.first(50) + '..'

  Request.create name: name,
                  message: message,
                  email: email,
                  department: department
end

puts Cowsay.say "Created #{REQUESTS_TO_CREATE} requests"
