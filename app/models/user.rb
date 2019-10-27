class User < ApplicationRecord
  has_secure_password
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :posts_liked, through: :likes, source: :post
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :email, length: { in: 2..50 }, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :first_name, :last_name, length: { in: 2..50 }, presence: true
  before_save { |user| user.email = user.email.downcase }
  validates :password, presence: true, length: { in: 2..50 }, on: :create
end
