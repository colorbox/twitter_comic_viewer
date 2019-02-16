class CreateMedia < ActiveRecord::Migration[5.2]
  def change
    create_table :media do |t|
      t.references :tweet, null: false
      t.string :image_url, null: false

      t.timestamps
    end
  end
end
