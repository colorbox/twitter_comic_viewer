class User < ApplicationRecord
  has_many :comics, dependent: :destroy

  def create_comic_cover(tweet_id)
    tweet_entity = client.status(tweet_id)

    author = Author.find_or_initialize_by(
            twitter_identifier: tweet_entity.user.id
    )

    author.update(
            name: tweet_entity.user.name,
            screen_name: tweet_entity.user.screen_name,
            avatar_url: tweet_entity.user.profile_image_url.to_s
    )

    author.comics.create(user: self)
  end

  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['CONSUMER_KEY']
      config.consumer_secret = ENV['CONSUMER_SECRET']
      config.access_token = access_token
      config.access_token_secret = access_token_secret
    end
  end
end
