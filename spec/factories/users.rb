FactoryBot.define do
  factory :user do
    nickname {Faker::Name.name}
    email {Faker::Internet.free_email}
    password {Faker::Internet.password(min_length: 6, max_length: 128)}
    password_confirmation {password}
    last_name {Faker::Japanese::Name.last_name}
    first_name {Faker::Japanese::Name.first_name}
    last_name_spelling {last_name.yomi}
    first_name_spelling {first_name.yomi}
    birthday {Faker::Date.birthday}
  end
end