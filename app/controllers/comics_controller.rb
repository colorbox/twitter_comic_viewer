class ComicsController < ApplicationController
  before_action :set_request_variant

  def create
    @user = User.find_by(access_token: session[:token])

    comic = @user.create_comic_cover(tweet_params[:tweet_id])

    comic.complete_pages(tweet_params[:tweet_id])

    redirect_to root_path
  end

  def show
    @user = User.find_by(access_token: session[:token])

    @comic = @user.comics.find(params[:id])

    respond_to :html, :'html.smartphone'
  end

  private

  def tweet_params
    params.permit(:tweet_id)
  end
end
