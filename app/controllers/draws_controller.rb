class DrawsController < ApplicationController
  before_action :check_login

  def create
    @draw= Draw.new(draw_params)
    @draw.user_id = current_user.id
    if @draw.save
      @msg = Draw.includes(:user).where('user_id = ? AND receiver_id = ? AND status =  0',@draw.receiver_id,current_user.id)
      if(@msg.length>0)

        @msg.first.status=1
        @msg.first.save

        @draw.status=1
        @draw.save

        @notice=Message.new
        @notice.notify_draw(@msg.first,current_user)

        @notice2=Message.new
        @notice2.notify_draw(@draw,@msg.first.user)

        respond_to do |format|
          format.js { render :action => "has_msg" }
        end
      else
        respond_to do |format|
          format.js { render :action => "no_msg" }
        end
      end
    end
  end

  private
  def draw_params
    params.require(:draw).permit(:content,:receiver_id)
  end
end
