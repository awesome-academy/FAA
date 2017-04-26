class Education::Course < ApplicationRecord
  translates :detail

  belongs_to :training, ->{with_deleted}, class_name: Education::Training.name

  has_many :course_members, class_name: Education::CourseMember.name,
    foreign_key: :course_id, dependent: :destroy
  has_many :users, through: :course_members
  has_many :images, class_name: Education::Image.name, as: :imageable,
    dependent: :destroy
  has_many :techniques, through: :training

  delegate :id, to: :training, prefix: true, allow_nil: true

  validates :name, presence: true,
    length: {maximum: Settings.education.course.max_name_length}
  validates :detail, presence: true

  scope :newest, ->{order created_at: :desc}
  scope :relation_training, ->training_id do
    where training_id: training_id
  end

  scope :by_training, ->training_id do
    where training_id: training_id if training_id.present?
  end

  accepts_nested_attributes_for :images, allow_destroy: true
end
