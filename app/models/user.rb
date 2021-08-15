class User < ApplicationRecord
  before_save {self.email = email.downcase}
  has_many :articles, dependent: :destroy
  has_many :followed_users, foreign_key: :follower_id, class_name: 'Following'
  has_many :followees, through: :followed_users
  has_many :following_users, foreign_key: :followee_id, class_name: 'Following'
  has_many :followers, through: :following_users
  has_secure_password
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: {minimum: 3 , maximum:32}
  VALID_EMAIL_EXPRESSION = /\A[a-z0-9\+\-_\.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, length: { maximum:105}, format: {with: VALID_EMAIL_EXPRESSION}
  
end