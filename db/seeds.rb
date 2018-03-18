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

# Category
50.times do |n|
  name = Faker::Lorem.sentence(2, true, 0)
  description = Faker::Lorem.sentence
  Category.create!(
    name: name,
    description: description)
end

# users = User.all
# user  = users.first
# following = users[2..50]
# followers = users[3..40]
# following.each { |followed| user.follow(followed) }
# followers.each { |follower| follower.follow(user) }
