class Post < ApplicationRecord
  acts_as_votable
  acts_as_taggable_on :tags
  acts_as_commentable

  belongs_to :user

  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true
  validates :archive, inclusion: { in: [true, false] }

  scope :order_by_date, -> { order(created_at: :desc) }
  scope :archived,      -> { where(archive: true) }
  scope :non_archived,  -> { where(archive: false) }
  scope :find_posts,    ->(query) { joins(:tags).where("lower(title) LIKE :query OR lower(body) LIKE :query OR tags.name LIKE :query", query: "%#{query.downcase}%") }
end
