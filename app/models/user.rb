class User < ApplicationRecord
  has_many :articles
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: {minimum: 3 , maximum:32}
  VALID_EMAIL_EXPRESSION = /\A[a-z0-9\+\-_\.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, length: { maximum:105}, format: {with: VALID_EMAIL_EXPRESSION}
end