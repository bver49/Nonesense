class AddCategoryToUser < ActiveRecord::Migration
  def change
    add_column :users, :category, :string
    add_column :users, :logincount, :integer, :default => 0
  end
end
