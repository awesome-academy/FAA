module Education::HomeHelper
  def courses_select_options
    Education::Course.newest.map{|course| [course.name, course.id]}
  end
end
