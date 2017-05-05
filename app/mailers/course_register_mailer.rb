class CourseRegisterMailer < ApplicationMailer
  def course_register course, receiver_mail, receive_name
    @course = course
    @receiver_mail = receiver_mail
    @receive_name = receive_name
    mail to: receiver_mail
  end
end
