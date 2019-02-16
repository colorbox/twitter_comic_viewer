class ComicsController < ApplicationController
  def create
    @user = User.find_by(access_token: session[:token])

    comic = @user.comics.create

    comic.complete_pages(tweet_params[:tweet_id])

    redirect_to root_path
  end

  private

  def tweet_params
    params.permit(:tweet_id)
  end
end
