User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

users = User.order(:created_at).take(6)
50.times do
  if_content   = Faker::Lorem.sentence(1)
  then_content = Faker::Lorem.sentence(1)
  users.each { |user| user.ifthen_rules.create!(if_content: if_content, then_content: then_content) }
end
