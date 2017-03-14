class WeekRecipes < ActiveRecord::Base
  belongs_to :week
  belongs_to :recipe
end
