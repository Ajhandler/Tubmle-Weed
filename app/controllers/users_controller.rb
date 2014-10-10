class UsersController < ApplicationController
 	before_action :set_user, only: [ :show, :edit, :update, :destroy, :follow, :unfollow]
 	
 	def current_user
		session[:user_id] ? User.find(session[:user_id]) : nil
	end

 	def index
 		@post = Post.new
 	end

	def show
	
	end

	def follow
		@rel = Relationship.new(follower_id: session[:user_id], followed_id: @user.id)
		if @rel.save
			flash[:notice] = 'Youre Now following'
			redirect_to @user 
		else
			flash[:alert] = "something went wrong"
			redirect_to @user
		end

	end

	def unfollow
		@rel = Relationship.where(follower_id: session[:user_id], followed_id: @user.id)
		@actual = @rel[0]
		if @actual and @actual.destroy
			flash[:notice] = "unfollowed"
			redirect_to @user
		else
			flash[:notice] = "something went wrong"
			redirect_to @user
		end
	end
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			flash[:notice] = "Welcome to Tumble Weed!"
			redirect_to users_path
		else
			flash[:alert] = "Something went Wrong."
			render :new
		end
	end

	def edit	
	end

	def update
		if @user.update(user_params)
			flash[:notice] = "profile update"
			redirect_to users_path
		else
			flash[:alert] = "something went wrong"
			render :edit
		end
	end

	def destroy
		if @user.destroy
			flash[:notice] = "Account Deleted, pls dont go."
			redirect_to new_session_path
		else
			flash[:alert] = "oops something went wrong! Sorry!"
			redirect_to users_path
		end
	end

	private
		def user_params
			params.require(:user).permit(:fname,:email,:password)	
		end

		def set_user
			@user = User.find(params[:id])
		end
	
end