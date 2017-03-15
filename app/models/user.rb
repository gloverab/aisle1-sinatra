class User < ActiveRecord::Base
  has_secure_password
  validates :name, :email, :username, :password, presence: true
  validates_uniqueness_of :username

  has_many :recipes
  has_many :ingredients, through: :recipes

  has_many :weeks
end
