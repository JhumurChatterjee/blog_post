class Comment < ApplicationRecord
  acts_as_nested_set scope: %i[commentable_id commentable_type]

  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :body, presence: true

  def self.build_from(obj, user_id, comment)
    new(commentable: obj, body: comment, user_id: user_id)
  end
end
