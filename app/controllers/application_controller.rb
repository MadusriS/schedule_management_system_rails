class ApplicationController < ActionController::Base
  before_action :set_cache_headers, if: :user_logged_in?
    helper_method :current_user
  
    private
  
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
    def user_logged_in?
      session[:user_id].present?
    end
  
    def set_cache_headers
      response.headers["Cache-Control"] = "no-store"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "0"
    end
  end
  
