User.create!(name: "Hieu Trung Nguyen",
  email: "admin@gmail.com",
  password: "password",
  password_confirmation: "password",
  is_admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@gmail.com"
  password = "password"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password)
end
