class ApplicationController < ActionController::Base
  def set_request_variant
    request.variant = request.device_variant # :pc, :smartphone
  end
end
