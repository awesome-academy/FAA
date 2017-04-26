class Education::Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true, optional: true
  mount_uploader :url, ImageUploader
end
