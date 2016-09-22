User.create! name: "Admin User",
             email: "admin@gmail.com",
             password: "password",
             password_confirmation: "password",
             admin: true

User.create! name: "User",
             email: "user@gmail.com",
             password: "password",
             password_confirmation: "password"

10.times do |n|
  name  = Faker::Name.name
  email = "Test-#{n+1}@gmail.com"
  password = "password"
  User.create! name:  name,
               email: email,
               password: password,
               password_confirmation: password
end

# Subjects
30.times do
  name  = Faker::Name.name
  description = Faker::Lorem.sentence
  Subject.create! name: name, description: description, duration: 60, number_of_questions: 5
end
