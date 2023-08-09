module Authenticators
  extend ActiveSupport::Concern

  def authenticate
    access_denied unless Auth::SessionManager.valid?(request_jwt_token)
  end

  def authorized?
    true
  end

  def current_customer
    current_user&.customer
  end

  def current_user
    return @current_user if @current_user.present?

    token_info = Auth::SessionManager.info(request_jwt_token)
    @current_user ||= Auth::CurrentUser.new(token_info)
  end
  # helper_method :current_user

  private

  def request_jwt_token
    token, _options = token_and_options(request)
    token
  end
end
