class UserMailer < ApplicationMailer
  default :from => "test@example.org"

  def authmail(user)
    @url = "http://localhost:3000/auth?email=#{user.email}&token=#{user.created_at.to_i}"

    mail to: "#{user.email}"
  end
end
