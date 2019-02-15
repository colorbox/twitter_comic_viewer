class ComicsController < ApplicationController
  def create
    @user = User.find_by(access_token: session[:token])

    comic = @user.comics.create

    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['CONSUMER_KEY']
      config.consumer_secret = ENV['CONSUMER_SECRET']
      config.access_token = @user.access_token
      config.access_token_secret = @user.access_token_secret
    end

    tweet = client.status(tweet_params[:tweet_id])

    comic.tweets.create(tweet_identifier: tweet.id.to_s)

    comic.finish

    redirect_to root_path
  end

  private

  def tweet_params
    params.permit(:tweet_id)
  end
end
