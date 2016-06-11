class UserMailer < ApplicationMailer
  default :from => "example@gmail.com"

  def authmail(user)
    @url = "http://localhost:3000/auth?email=#{user.email}&token=#{user.created_at.to_i}"

    mail to: user.email , subject: '驗證信'
  end
end
