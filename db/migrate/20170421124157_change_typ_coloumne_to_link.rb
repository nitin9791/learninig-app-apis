class ChangeTypColoumneToLink < ActiveRecord::Migration[5.0]
  def change
  	change_column :links, :type, :integer, index: true, dafault: 0
  end
end
