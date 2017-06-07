module Education::CoursesHelper
  def training_select
    Education::Training.with_deleted.all.map do |training|
      [training.name, training.id]
    end
  end

  def check_size_max?
    training_select.size > Settings.courses.number_filter
  end

  def slice_collection collection
    part_num = Settings.courses.part_num.to_f
    collection.each_slice((collection.length / part_num).ceil).to_a
  end

  def current_course_path
    Settings.courses.current_string unless params[:training_id]
  end

  def current_path_course? training
    Settings.courses.current_string if params[:training_id] == training.last.to_s
  end

  def button_status course
    content_tag :div, course.status,
      class: "btn pull-right #{course.close? ? "btn-danger" : "btn-success"}"
  end

  def sale_off cost
    (cost * Settings.courses.sale_percent).round Settings.courses.round_price if cost
  end

  def date_show date
    l date, format: :date_month_year_concise if date
  end
end
