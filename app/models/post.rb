class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true
  validates :archive, inclusion: { in: [true, false] }

  scope :archived,     -> { where(archive: true) }
  scope :non_archived, -> { where(archive: false) }
end
