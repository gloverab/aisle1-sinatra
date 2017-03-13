class CreateIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table(:ingredients) do |t|
      t.string :name
      t.integer :category_id
    end
  end
end
