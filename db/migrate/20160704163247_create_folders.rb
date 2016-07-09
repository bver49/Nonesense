class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.string :title
      t.text :about
      t.integer :user_id
      t.timestamps null: false
    end
    add_index :folders, :user_id
  end
end
