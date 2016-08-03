class Message < ActiveRecord::Base
    validates_presence_of :title
    validates_presence_of :body

    def sender
      User.find(sender_id)
    end

    def notify_post(user,post)
      self.types = 1
      self.sender_id = post.id
      self.title = "通知"
      self.body ="#{user} 按了你的文章 #{post.title} 讚"
      self.receiver_id = post.user_id
      self.save
    end

    def notify_follow(user,following_id)
      self.types = 2
      self.sender_id = user.id
      self.title = "通知"
      self.body = user.name + " 開始追蹤你"
      self.receiver_id = following_id
      self.save
    end

    def notify_comment(user,post)
      self.types = 3
      self.sender_id = post.id
      self.title = "通知"
      self.body ="#{user} 在你的文章 #{post.title} 留言"
      self.receiver_id = post.user_id
      self.save
    end

    def notify_draw(user,current_user)
      self.types = 4
      self.sender_id = user.id
      self.title = "通知"
      self.body ="恭喜你和 #{user.name} 配對成功"
      self.receiver_id = current_user.id
      self.save
    end
end
