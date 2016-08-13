class AddPostIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :post_id, :integer, :default => 0
  end
end
