class ApplicationController < ActionController::Base
  protect_from_forgery
  include ApplicationHelper
  helper_method :current_user
  before_filter :check_login
end
