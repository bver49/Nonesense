class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :image
      t.text :content
      t.integer :folder_id,:default => 0
      t.timestamps null: false
    end
  end
end
