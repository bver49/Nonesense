module MessagesHelper
  def mynotice
     Message.where("receiver_id = ? AND types != ?",current_user.id,'0').order("created_at desc").limit(3)
  end
end
