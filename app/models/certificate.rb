class Certificate < ApplicationRecord
  has_many :user_certificates, dependent: :destroy
  has_many :users, through: :user_certificates
  has_one :image, as: :imageable, class_name: Education::Image,
    dependent: :destroy

  validates :title, presence: true, length: {
    minimum: Settings.certificates.title_min_length,
    maximum: Settings.certificates.title_max_length}
  validates :description, presence: true, length: {
    minimum: Settings.certificates.description_min_length,
    maximum: Settings.certificates.description_max_length}

  accepts_nested_attributes_for :image
end
