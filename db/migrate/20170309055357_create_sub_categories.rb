class CreateSubCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :sub_categories do |t|
      t.string :name, null: false, index: {unique: true}
      t.integer :status,  null: false, index: {unique: true}
      t.references :category, null: false, foreign_key: true
      t.timestamps
    end
  end
end
