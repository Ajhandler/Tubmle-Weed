class SessionsController < ApplicationController
	def new

	end

	def create
		@user = User.where(email: params[:email]).first
		if @user and @user.password == params[:password]
		session[:user_id] = @user.id
	 	flash[:notice] = "logged in"
	 	redirect_to users_path
	 	else
	 	flash[:alert] = "Did not log in"
	 	redirect_to new_session_path
	 	end
	end

	def destroy
		@user = User.find(session[:user_id])
		session[:user_id] = nil
		flash[:notice] = "logged out"
		redirect_to new_session_path
	end
end