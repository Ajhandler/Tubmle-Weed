class CommentsController < ApplicationController
	def create
		@post = Post.find(params[:post_id])
    	@comment = @post.comments.new(comment_params)
    	@comment.user = current_user
   		@comment.save
    	redirect_to post_path(@post)
	end

	private

	def comment_params
		params.require(:comment).permit( :body, :post_id, :user_id)
	end
	def current_user
		session[:user_id] ? User.find(session[:user_id]) : nil
	end

end
