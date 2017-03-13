class CreateRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table(:recipes) do |t|
      t.string :name
      t.string :cooktime
      t.integer :user_id
    end
  end
end
