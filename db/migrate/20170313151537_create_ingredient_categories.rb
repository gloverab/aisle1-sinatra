class CreateIngredientCategories < ActiveRecord::Migration[5.0]
  def change
    create_table(:ingredient_categories) do |t|
      t.integer :ingredient_id
      t.integer :category__id
    end
  end
end
