class PostsController < ApplicationController

	def home
		@posts = Post.all
		# session[:id] = @user.id
		@user = session[:id]
	end

	def index
		@post = Post.all
		# @user = User.find(params[:id])
		@user = User.find(session[:id])
		
	end

    def create
    	@user = current_user
    	@post = Post.new(user: @user, content: params[:content])
      	if @post.valid?
      		@post.save
      		redirect_to '/posts'
      	else
      		flash[:error] = "Must be 2 or more characters"
      	redirect_to "/posts"
      end
  	end

  	def edit
  		@user = User.find(session[:id])
  		@post = Post.find(params[:id])
  		if @post.user.id != @user.id
  			flash[:error] = "You may not change the post of anther user!"
      		redirect_to '/posts/#{@post.id}/edit'
    	end
  	end

  	def update
  		@user = current_user
  		@post = Post.find(params[:id])
  		if @post.valid?
      		@post.update(content: params[:content]) if @post.user == current_user
      		redirect_to '/posts'
      	else
      		flash[:error] = "Must be 2 or more characters"
      		redirect_to '/posts/#{@post.id}/edit'
      	end
      	# WAS WORKING HERE FOR NO EMPTRY UPDATE POST!
  	end
  		
  	def destroy
  		@user = current_user
  		@post = Post.find(params[:id])
  		puts @post.user
  		@post.destroy if @post.user == current_user
  		redirect_to "/posts"
  	end

	private
	def post_params
		params.require(:post).permit(:content, :user_id)
	end
end