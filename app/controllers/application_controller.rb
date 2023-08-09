class ApplicationController < ActionController::API
  before_action :authenticate
  before_action :authorized?

  include ActiveStorage::SetCurrent
  include ActionController::HttpAuthentication::Token
  include ApiListMethods
  include Authenticators
  include ErrorMessages
  include FormatterMethods
  include FileDownload
  include ObjectResponders
  include ParamSetters
  include ParamHelpers
end
