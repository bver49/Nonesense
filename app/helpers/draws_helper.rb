module DrawsHelper
  def today_draw
    @draw = Draw.where('user_id = ? AND created_at BETWEEN ? AND ?',current_user.id, DateTime.now.beginning_of_day, DateTime.now.end_of_day)
    @id=[]
    @draw.each do |draw|
      @id.push(draw.post_id)
    end
    @drawpost = Post.where("id IN (?)",@id)
  end
end
