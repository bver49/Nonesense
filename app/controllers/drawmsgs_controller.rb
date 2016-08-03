class DrawmsgsController < ApplicationController
  before_action :check_login

  def create
    @drawmsg= Drawmsg.new(drawmsg_params)
    @drawmsg.user_id = current_user.id
    if @drawmsg.save
      @msg = Drawmsg.includes(:user).where('user_id = ? AND receiver_id = ? AND status =  0',@drawmsg.receiver_id,current_user.id)
      if(@msg.length>0)

        @msg.first.status=1
        @msg.first.save

        @drawmsg.status=1
        @drawmsg.save

        @notice=Message.new
        @notice.notify_draw(@msg.first,current_user)

        @notice2=Message.new
        @notice2.notify_draw(@drawmsg,@msg.first.user)

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
  def drawmsg_params
    params.require(:drawmsg).permit(:content,:receiver_id)
  end
end
