class CommentsController < ApplicationController
  def create
  	@post=Post.find(params[:post_id])
  	@comment = @post.comments.new(comment_params)
  	@comment.user_id = current_user.id
  	@comment.save!

    @notice=Message.new
    @notice.notify_comment(current_user.name,@post)

    respond_to do |format|
  		format.html { redirect_to @post}
  		format.js
  	end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @post}
      format.js
    end
  end

  private
  def comment_params
  	params.require(:comment).permit(:body)
  end
end
