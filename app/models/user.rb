class User < ApplicationRecord
  acts_as_voter

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable, :trackable

  before_validation do
    self.first_name = first_name.to_s.squish.titleize
    self.last_name = last_name.to_s.squish.titleize
  end

  has_many :posts, dependent: :destroy

  validates :first_name, :last_name, presence: true, length: { maximum: 255 }

  def full_name
    "#{first_name} #{last_name}"
  end

  def initial
    "#{first_name[0]}#{last_name[0]}"
  end
end
