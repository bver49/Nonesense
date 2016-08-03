class MessagesController < ApplicationController
  before_action :check_login
  before_action :find_msg, only: %i[show destroy]

  def new
    @msg = Message.new
  end

  def create
    @msg= Message.new(msg_params)
    @msg.sender_id = current_user.id
    @msg.save
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @msg.destroy
    respond_to do |format|
      format.js
    end
  end

  def show
    @msg.status = 1
    @msg.save
  end

  def index
    @msg = Message.where(receiver_id: current_user.id,types:'0').order("created_at desc")
  end

  def notice
    @notice = Message.where("receiver_id = ? AND types != ?",current_user.id,'0').order("created_at desc")
  end

  def clearnotify
    @notify = Message.where("receiver_id = ? AND types != ? AND status = ?",params[:id],'0','0')
    @notify.each do |n|
      n.status=1
      n.save
    end
    respond_to do |format|
      format.any { render :text => "Clear" }
    end
  end
  private
  def find_msg
    @msg=Message.find(params[:id])
  end

  def msg_params
    params.require(:message).permit(:title,:body,:receiver_id)
  end

end
