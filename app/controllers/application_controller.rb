class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    puts"-------------------current_user-----------------------"
  	User.find(session[:id]) if session[:id]
  end

  def require_correct_user
    puts"-------------------require_correct_user-----------------------"
    user = User.find(params[:id])
    redirect_to "/sessions" if current_user != user
  end

  def require_login
    puts"-------------------require_login-----------------------"
    redirect_to '/sessions/new' if session[:id] == nil
  end
  def is_allowed user_id
    if session[:user_id] != user_id
      flash[:errors] = ["Permission denied!"]
      redirect_to "/sessions/new"
      return false
    end
    return true
  end
  helper_method :current_user
end

