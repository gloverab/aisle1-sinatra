class CreateWeekRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table(:week_recipes) do |t|
      t.integer :week_id
      t.integer :recipe_id
    end
  end
end
