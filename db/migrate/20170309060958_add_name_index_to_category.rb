class AddNameIndexToCategory < ActiveRecord::Migration[5.0]
  def change
  	add_index :categories, :name, unique: true
  	add_index :categories, :status, unique: true
  end
end
