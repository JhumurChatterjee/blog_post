class Comment < ApplicationRecord
  belongs_to :post

  validates :content, presence: true
  validates :archive, inclusion: { in: [true, false] }

  delegate :user, to: :post

  scope :order_by_date, -> { order(created_at: :desc) }
  scope :archived,      -> { where(archive: true) }
  scope :non_archived,  -> { where(archive: false) }
end
