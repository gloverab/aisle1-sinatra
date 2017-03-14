class Recipe < ActiveRecord::Base
  validates :name, :cooktime, presence: true
  
  belongs_to :user

  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  has_many :week_recipes
  has_many :weeks, through: :week_recipes

  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
end
