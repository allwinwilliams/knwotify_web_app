class CreateUsersCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :users_categories do |t|
      t.integer :user_id
      t.integer :category_id

      t.timestamps
    end
    add_index :users_categories, :user_id
    add_index :users_categories, :category_id
    add_index :users_categories, [:user_id, :category_id], unique: true
    
  end
end
