class AddTypeToLink < ActiveRecord::Migration[5.0]
  def change
  	add_column :links, :type, :integer, index: true
  end
end
