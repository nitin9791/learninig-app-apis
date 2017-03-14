class ChangeColoumnFromTables < ActiveRecord::Migration[5.0]
  def change
  	change_table :categories do |t|
  		t.remove_index :status
  		t.index :status, unique: false
  	end
  	change_table :sub_categories do |t|
  		t.remove_index :status
  		t.index :status, unique: false
  	end
  end
end
