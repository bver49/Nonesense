class RenameMessageColumn < ActiveRecord::Migration
  def change
     rename_column :messages, :sender_id, :user_id
     add_column :messages, :post_id, :integer, :default => 0
     add_index :messages, :user_id
  end
end
