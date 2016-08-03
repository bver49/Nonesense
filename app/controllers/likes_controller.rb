class LikesController < ApplicationController
  before_action :check_login
  def likepost
    @post = Post.find(params[:id])
    @like = @post.likes.new
    @like.user_id = current_user.id
    @like.post_id = @post.id
    @like.save!

    if @post.user_id != current_user.id
      @notice=Message.new
      @notice.notify_post(current_user.name,@post)
    end

    respond_to do |format|
      format.js
    end
  end

  def unlikepost
    @like=Like.where(user_id: current_user.id,post_id: params[:id]).first
    @like.destroy
    respond_to do |format|
      format.js
    end
  end
end
