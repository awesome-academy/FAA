class Education::Technique < ApplicationRecord
  translates :description
  acts_as_paranoid

  has_many :project_techniques, ->{with_deleted},
    class_name: Education::ProjectTechnique.name,
    foreign_key: :technique_id
  has_many :projects, ->{with_deleted}, through: :project_techniques
  has_many :training_techniques, ->{with_deleted},
    class_name: Education::TrainingTechnique.name,
    foreign_key: :technique_id
  has_many :trainings, ->{with_deleted}, through: :training_techniques

  has_one :image, as: :imageable, class_name: Education::Image,
    dependent: :destroy

  delegate :url, to: :image, prefix: true

  validates :name, presence: true,
    length: {maximum: Settings.education.technique.max_name_length}

  scope :newest, ->{order created_at: :desc}

  accepts_nested_attributes_for :image
end
