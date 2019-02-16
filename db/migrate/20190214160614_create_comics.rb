class CreateComics < ActiveRecord::Migration[5.2]
  def change
    create_table :comics do |t|
      t.references :user, null: false
      t.string :name, null: false, default: ''

      t.timestamps
    end
  end
end
