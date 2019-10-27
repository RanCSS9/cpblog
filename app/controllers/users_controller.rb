class UsersController < ApplicationController
	  # skip_before_filter :require_login, :only => [:create,:new]
	  # before_action :check_user, only: [:edit, :show, :update, :delete]
    before_filter :correct_user,   only: [:show]
  
  def new
  end
  
  def create
  	puts "———————————Start—————————————————————————————————————————————————————————————"
  	@user = User.create(user_params)
    if @user.valid?
      @user.save
      redirect_to '/sessions/new'
    else
      flash[:error] = "can't be blank, Incorrect email format, names must be longer than 2 characters, password longer than 8 characters"
      redirect_to "/users/new"
    end
    puts "———————————End—————————————————————————————————————————————————————————————"
  end

  def show
    puts "———————————Start—————————————————————————————————————————————————————————————"
    @posts = Post.all
    @user = User.find(params[:id])
    puts "———————————End—————————————————————————————————————————————————————————————"
  end

  def edit
    puts "———————————Start—————————————————————————————————————————————————————————————"
    @posts = Post.all
    @sesh = User.find(session[:id])
    @user = User.find(params[:id])
    if @user.id != @sesh.id
      session[:id] = nil
      redirect_to '/'
    end
    puts "———————————End—————————————————————————————————————————————————————————————"
  end

  def update
    @user = User.find(params[:id])
    @sesh = User.find(session[:id])
    @user.update(user_params)
    if @user.id != @sesh.id
      flash[:error] = "I SEE WHAT YOUR TRYING TO DO SLICK! YOU'VE BEEN LOGGED OUT. I WILL BE FORCED TO REPORT YOUR BAHAVIOR TO SITE ADMIN IF THIS PERSIST!"
      session[:id] = nil
      redirect_to '/'
    elsif @user.valid?
      @user.save
      redirect_to "/posts"
    else
      flash[:error] = "No blank fields, Incorrect email format, names must be longer than 2 characters, password longer than 8 characters"
      redirect_to "/users/#{@user.id}/edit"
    end
  end

  def destroy
    puts "--------------------UsersController-----------------------destroyMethod------------------"
    @user = User.find(params[:id])
    @user.destroy
    reset_session
    redirect_to '/'
    puts "———————————Start—————————————————————————————————————————————————————————————"
  end

  private
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

    # def check_user
    # 	if current_user != User.find(params[:id])
    #       redirect_to "/"
    #   end
    # end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
