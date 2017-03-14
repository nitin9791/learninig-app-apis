class CreateVideoLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :video_links do |t|

      t.timestamps
    end
  end
end
