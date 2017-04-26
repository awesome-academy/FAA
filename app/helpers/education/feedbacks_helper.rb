module Education::FeedbacksHelper
  def is_notice_flash? message_type
    %w(success notice).include? message_type
  end
end
