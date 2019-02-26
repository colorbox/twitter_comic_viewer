class Tweet < ApplicationRecord
  belongs_to :comic
  has_many :media, dependent: :destroy

  def ordered_media
    media.order(id: :asc)
  end

  def tweet_permalink
    "https://twitter.com/#{comic.author.screen_name}/status/#{tweet_identifier}"
  end
end
