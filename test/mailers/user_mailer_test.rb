require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "sending_password" do
    mail = UserMailer.sending_password
    assert_equal "Sending password", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
