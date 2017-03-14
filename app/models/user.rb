class User < ActiveRecord::Base
  has_secure_password
  validates :name, :email, :username, :password, presence: true

  has_many :recipes
  has_many :ingredients, through: :recipes

  has_many :weeks
end
