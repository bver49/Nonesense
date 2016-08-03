class CreateDrawmsgs < ActiveRecord::Migration
  def change
    rename_table :draws, :drawmsgs
    create_table :draws do |t|
      t.integer :post_id
      t.integer :user_id
      t.timestamps null: false
    end
    add_index :draws, :user_id
    add_index :draws, :post_id
  end
end
