class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :destroy]
	def index
		@posts = Post.all
	end

	def show
		
	end
	def create
		@post = Post.new(post_params)
		@post.user = User.find(session[:user_id])
		if @post.save
			flash[:notice] = "New Post Sent!"
			redirect_to @post
		else
			flash[:alert] = "no bueno"
			render :new
		end
	end

	def edit
		
	end

	def update

		if @post.update(post_params)
			flash[:notice] = "Nice edit!"
			redirect_to @post
		else
			flash[:alert] = "Bad edit :("
			render :edit
		end
	end

	def destroy
		# @chirp = Chirp.find(params[:id]) this happens in before_action
		@post.destroy
		flash[:notice] = "post deleted"
		redirect_to users_path
	end

	private

	def post_params
		params.require(:post).permit( :title, :body, :user_id)
	end

	def set_post
		@post = Post.find(params[:id])
	end
end