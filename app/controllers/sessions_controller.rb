class SessionsController < ApplicationController
  protect_from_forgery

  def new
    auth = request.env['omniauth.auth']
    user = User.find_or_initialize_by(twitter_identifier: auth.uid)
    user.update!(
      screen_name: auth.info.nickname,
      access_token: auth.credentials.token,
      access_token_secret: auth.credentials.secret,
      name: auth.info.name
    )
    session[:token] = user.access_token
    session[:token_secret] = user.access_token_secret
    session[:screen_name] = user.screen_name

    redirect_to root_path
  rescue Twitter::Error::TooManyRequests
    redirect_to root_path
  end
end
