class Category < ActiveRecord::Base
  has_many :ingredient_categories
  has_many :ingredients, through: :ingredient_categories
end
