class Education::About < ApplicationRecord
  translates :title, :content

  has_one :image, class_name: Education::Image.name, as: :imageable

  validates :title, presence: true
  validates :content, presence: true

  accepts_nested_attributes_for :image, allow_destroy: true
end
