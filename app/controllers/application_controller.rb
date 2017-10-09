class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SetI18nLocale
  include SetLayoutDefaults
  include SetDeviseWhitelist
end