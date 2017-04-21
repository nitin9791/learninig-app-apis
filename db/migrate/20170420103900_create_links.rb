class CreateLinks < ActiveRecord::Migration[5.0]
  def change
    create_table     :links do |t|
    	t.string     :name
    	t.text       :description
    	t.integer    :status, index: {unique: false}
    	t.references :category, foreign_key: true
    	t.string     :url
    end
  end
end
