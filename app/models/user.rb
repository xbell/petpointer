class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :email, format: {with: /@/}
  validates :username, presence: true, uniqueness: true
end
