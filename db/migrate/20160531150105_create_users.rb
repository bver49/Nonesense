class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :avatar
      t.integer :role,:default => 0
      t.string :password_digest
      t.text :about
      t.timestamps null: false
    end
  end
end
