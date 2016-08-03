class RelationshipsController < ApplicationController
  before_action :check_login
  def follow_user
    @user = User.find_by! id: params[:id]
    if current_user.follow @user.id

      @notice=Message.new
      @notice.notify_follow(current_user,@user.id)

      respond_to do |format|
        format.js
      end
    end
  end

  def unfollow_user
    @user = User.find_by! id: params[:id]
    if current_user.unfollow @user.id
      respond_to do |format|
        format.js
      end
    end
  end
end
