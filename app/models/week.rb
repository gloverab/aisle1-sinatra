class Week < ActiveRecord::Base
  belongs_to :user

  has_many :week_recipes
  has_many :recipes, through: :week_recipes

  include Helper

  def ingredients
    recipes.map(&:ingredients).flatten
  end

  def duplicate_ingredients
    ingredients.find_all { |ingredient| ingredients.count(ingredient) > 1}
  end

  def display_duplicates
    b = Hash.new(0)

    duplicate_ingredients.each do |dupe|
      b[dupe] += 1
    end

    b

    # b.each do |ingredient, v|
    #   ingredient.name
    # end
  end

end
