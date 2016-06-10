require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "authmail" do
    mail = UserMailer.authmail
    assert_equal "Authmail", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
