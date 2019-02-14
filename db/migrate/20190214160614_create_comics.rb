class CreateComics < ActiveRecord::Migration[5.2]
  def change
    create_table :comics do |t|
      t.string :name, null: false, default: ''
      t.references :user, null: false

      t.timestamps
    end
  end
end
