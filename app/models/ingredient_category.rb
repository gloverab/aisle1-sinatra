class IngredientCategory < ActiveRecord::Base
  belongs_to :ingredient
  belongs_to :category
end
