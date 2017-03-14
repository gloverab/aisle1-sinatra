class Week < ActiveRecord::Base
  belongs_to :user

  has_many :week_recipes
  has_many :recipes, through: :week_recipes

  include Helper

  def ingredients
    recipes.map(&:ingredients).flatten
  end

end
