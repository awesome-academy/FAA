class FriendRequestMailer < ApplicationMailer
  def friend_request send_user, receive_user
    @send_user = send_user
    @receive_user = receive_user
    mail to: receive_user.email,
      subject: t(".subject", name: send_user.name)
  end
end
