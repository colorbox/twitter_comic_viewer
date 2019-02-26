class CreateAuthors < ActiveRecord::Migration[5.2]
  def change
    create_table :authors do |t|
      t.string :twitter_identifier, null: false
      t.string :screen_name, null: false
      t.string :name, null:false
      t.string :avatar_url, null: false

      t.timestamps
    end
  end
end
