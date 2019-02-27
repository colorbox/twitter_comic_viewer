class HomeController < ApplicationController
  before_action :set_request_variant

  def index
    respond_to :html, :'html.smartphone'
  end
end
