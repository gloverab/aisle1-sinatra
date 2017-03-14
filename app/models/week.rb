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
    duplicate_hash = Hash.new(0)

    duplicate_ingredients.each do |dupe|
      duplicate_hash[dupe] += 1
    end
    duplicate_hash
  end

end
