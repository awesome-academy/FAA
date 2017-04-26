module Education::TechniquesHelper
  def load_technique_image object
    image = object.image
    if image
      image_tag object.image_url, class: "img-circle img-circle-custom"
    else
      image_tag ImageUploader.new.default_url,
        class: "img-circle img-circle-custom"
    end
  end
end
