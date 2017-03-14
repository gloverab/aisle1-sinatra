class AddUseridColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :weeks, :user_id, :integer
  end
end
