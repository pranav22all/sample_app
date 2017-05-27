class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # gives all our controllers access to the Sessions helper module
  include SessionsHelper
end
