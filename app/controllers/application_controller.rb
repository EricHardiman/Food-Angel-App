class ApplicationController < ActionController::Base
  before_action :authorized #lock down this whole app
  skip_before_action :authorized, only: :index
  helper_method :current_user #i can call current_user from a view
  protect_from_forgery with: :exception

  def index
    render :index
  end

  def current_user
    # User.find would throw an error if we cannot find the user
    User.find_by({ id: session[:user_id] })
  end

  def logged_in?
    # nil is falsey in ruby
    # a user instance is truthy
    !!current_user
  end

  def authorized
    redirect_to login_path unless logged_in?
  end
end
