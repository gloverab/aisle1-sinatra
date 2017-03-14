class Week < ActiveRecord::Base
  belongs_to :user

  has_many :week_recipes
  has_many :recipes, through: :week_recipes

  include Helper

  def ingredients
    recipes.map(&:ingredients).flatten
  end

  # def duplicate_ingredients
  #   dupes = ingredients.find_all { |ingredient| ingredients.count(ingredient) > 1}
  #
  #   b = Hash.new(0)
  #
  #   dupes.each do |dupe|
  #     b[dupe] += 1
  #   end
  #
  #   b.each do |k, v|
  #     puts "#{k} appears #{v} times"
  #   end
  # end

end
