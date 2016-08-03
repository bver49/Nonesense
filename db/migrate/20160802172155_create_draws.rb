class CreateDraws < ActiveRecord::Migration
  def change
    create_table :draws do |t|
      t.text :content
      t.integer :receiver_id
      t.integer :user_id
      t.integer :status,:default => 0
      t.timestamps null: false
    end
    add_index :draws, :user_id
  end
end
