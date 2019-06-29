2.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.email
  password = "password"
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password
  )
end

User.create!(
    name: "testAdminUser",
    email: "test@admin.com",
    password: "password",
    admin: true,
    password_confirmation: "password",
  )

Label.create!([
                      {label: "ラベル1"},
                      {label: "ラベル2"},
                   ])
