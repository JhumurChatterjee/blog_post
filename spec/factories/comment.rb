FactoryBot.define do
  factory :comment do
    content { Faker::Company.name + Time.now.to_i.to_s }
    post
  end
end
