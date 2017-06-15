module Education::Management::CertificatesHelper
  def load_certificate_image object
    image = object.image
    if image
      image_tag object.image.url, class: "img-circle img-circle-custom"
    else
      image_tag ImageUploader.new.default_url,
        class: "img-circle img-circle-custom"
    end
  end
end
