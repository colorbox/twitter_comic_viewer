class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.references :comic, null: false
      t.string :tweet_identifier, null: false
      t.string :text, null: false, default: ''
      t.datetime :posted_at, null: false

      t.timestamps
    end
  end
end
