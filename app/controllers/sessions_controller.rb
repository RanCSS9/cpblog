class SessionsController < ApplicationController

  def new
    #render login page
  end

  def create
    @user = User.find_by(email: params[:email].downcase)
      if @user && @user.authenticate(params[:password])
        session[:id] = @user.id
        redirect_to "/sessions/#{@user.id}"
      else
        flash[:error] = "Email and password do not match."
        redirect_to "/sessions/new"
      end
  end
    #store downcased email and use that variable to find_by
  def show
    @sesh = User.find(session[:id])
    @user = User.find(params[:id])
     if @user.id != @sesh.id
      session[:id] = nil
      redirect_to '/'
    end
  end


    def destroy
      # Log User out
      # set session[:user_id] to nil
      # redirect to login page
      reset_session
      session[:id] = nil
      redirect_to '/'
    end
end

