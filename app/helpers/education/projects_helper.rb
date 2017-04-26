module Education::ProjectsHelper
  def split_array array_technique
    array_temp = array_technique
      .each_slice(Settings.education.projects.split_array).to_a
    if array_temp.size < Settings.education.projects.min_array_size
      return array_temp
    end
    array_technique_show = array_temp.delete_at(0)
    array_technique_hide = array_temp.flatten
    [array_technique_show, array_technique_hide]
  end

  def check_lenght_content object, data_target
    return unless object
    if object.size > Settings.education.project.content_truncate
      content_tag :a, href: "#", "data-toggle": "modal", class: "more-link",
        "data-target": data_target, "data-whatever": "@mdo" do
        t ".read_more"
      end
    end
  end

  def total_project
    Education::Project.all.size
  end

  def project_member_position
    Education::ProjectMember.positions
  end
end
