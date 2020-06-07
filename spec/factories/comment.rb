FactoryBot.define do
  factory :comment do
    body             { Faker::Types.rb_string }
    commentable_id   { create(:post).id }
    commentable_type { "Post" }
    user
  end
end
