class Week < ActiveRecord::Base
  belongs_to :user
  has_many :recipes
  has_many :ingredients, through: :recipes
end
