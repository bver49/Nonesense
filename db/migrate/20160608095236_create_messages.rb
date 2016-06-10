class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :title
      t.text :body
      t.integer :sender_id
      t.integer :receiver_id
      t.integer :status,:default => 0
      t.integer :types,:default => 0
      t.timestamps null: false
    end
  end
end
