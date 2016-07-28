class AddViewToUser < ActiveRecord::Migration
  def change
    add_column :users, :view, :integer, :default => 0
  end
end
