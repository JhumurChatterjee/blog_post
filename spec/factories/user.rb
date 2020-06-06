FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.middle_name }
    email      { Faker::Internet.email }
    password   { Faker::Internet.password(min_length: 6, max_length: 128) }

    after(:build) { |u| u.skip_confirmation! }
  end
end
