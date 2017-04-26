class Education::ProjectsSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :plat_form, :image_url

  def image_url
    if object.images.any?
      object.images.first.url
    else
      ImageUploader.new.default_url
    end
  end

  def description
    object.description.truncate Settings.education.project.content_truncate
  end
end
