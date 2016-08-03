module DrawsHelper
  def check_today_draw
    @draw = Draw.where('user_id = ? AND created_at BETWEEN ? AND ?',current_user.id, DateTime.now.beginning_of_day, DateTime.now.end_of_day).length
  end
end
