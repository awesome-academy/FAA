module Education::CourseRegistersHelper
  def select_status_course_register
    CourseRegister.statuses.map{|status, index| [status, index]}
  end

  def select_course
    Education::Course.all.map{|key| [key.name, key.id]}
  end

  def get_status_register_course course
    if course.status_registered?
      content_tag :span, t("education.course_status.registered"),
        class: "label label-warning", id: "course-status-label-#{course.id}"
    else
      content_tag :span, t("education.course_status.contacted"),
        class: "label label-success", id: "course-status-label-#{course.id}"
    end
  end

  def get_action_send_contact course
    if course.status_registered?
      content_tag :button, t("education.course_status.send_contact"),
        class: "btn btn-success send_contact_register",
        id: "send_contact_register_#{course.id}",
        data: {id: course.id, username: course.name,
          status: Settings.education.management.course_register.send_contact}
    else
      content_tag :button, t("education.course_status.reject_contact"),
        class: "btn btn-warning send_contact_register",
        id: "send_contact_register_#{course.id}",
        data: {id: course.id, username: course.name,
          status: Settings.education.management.course_register.reject_contact}
    end
  end
end
