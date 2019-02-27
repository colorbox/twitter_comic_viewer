class SessionsController < ApplicationController
  protect_from_forgery

  DEFAULT_AVATAR_URL = 'https://abs.twimg.com/sticky/default_profile_images/default_profile_normal.png'

  def new
    auth = request.env['omniauth.auth']
    avatar_url =  if auth.extra.raw_info.default_profile_image
                    DEFAULT_AVATAR_URL
                  else
                    auth.info.image
                  end
    user = User.find_or_create_by(
      twitter_identifier: auth.uid,
      screen_name: auth.info.nickname,
      access_token: auth.credentials.token,
      access_token_secret: auth.credentials.secret,
      name: auth.info.name,
      avatar_url: avatar_url
    )
    session[:token] = user.access_token
    session[:token_secret] = user.access_token_secret
    session[:screen_name] = user.screen_name

    redirect_to root_path
  rescue Twitter::Error::TooManyRequests
    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
