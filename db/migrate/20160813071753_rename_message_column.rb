class RenameMessageColumn < ActiveRecord::Migration
  def change
     rename_column :messages, :sender_id, :user_id
     add_index :messages, :user_id
  end
end
