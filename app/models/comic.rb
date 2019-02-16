class Comic < ApplicationRecord
  belongs_to :user
  has_many :tweets, dependent: :destroy

  def ordered_tweets
    tweets.includes(:media).order(id: :desc).order('media.id')
  end

  def complete_pages(tweet_identifier)
    add_page(tweet_identifier)

    loop do
      break unless binding
    end
  end

  private

  def add_page(tweet_identifier)
    tweet_entity = client.status(tweet_identifier)

    tweet = tweets.create(tweet_identifier: tweet_identifier)
    tweet_entity.media.each do |medium|
      next unless medium.type == 'photo'
      tweet.media.create(image_url: medium.media_url_https)
    end
  end

  def binding
    previous_tweet = fetch_previous_tweet(tweets.last)
    return if previous_tweet.blank?

    add_page(previous_tweet.id.to_s)
  end

  def fetch_previous_tweet(tweet)
    tweet_entity = client.status(tweet.tweet_identifier)

    return if tweet_entity.in_reply_to_status_id.class == Twitter::NullObject

    client.status(tweet_entity.in_reply_to_status_id)
  end

  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['CONSUMER_KEY']
      config.consumer_secret = ENV['CONSUMER_SECRET']
      config.access_token = user.access_token
      config.access_token_secret = user.access_token_secret
    end
  end
end
