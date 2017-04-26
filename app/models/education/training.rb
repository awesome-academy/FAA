class Education::Training < ApplicationRecord
  translates :description
  acts_as_paranoid

  has_many :courses, class_name: Education::Course.name,
    foreign_key: :training_id
  has_many :images, as: :imageable
  has_many :training_techniques, ->{with_deleted},
    class_name: Education::TrainingTechnique.name,
    foreign_key: :training_id, dependent: :destroy
  has_many :techniques, ->{with_deleted}, through: :training_techniques

  accepts_nested_attributes_for :images, allow_destroy: true

  validates :name, presence: true,
    length: {maximum: Settings.education.training.max_name_length}
  validates :description, presence: true

  scope :newest, ->{order created_at: :desc}

  scope :filter_by_technique, ->technique_name do
    left_outer_joins(:techniques)
      .where("education_techniques.name LIKE ?", technique_name).distinct
  end
end
