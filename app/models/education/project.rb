class Education::Project < ApplicationRecord
  include PublicActivity::Model
  tracked owner: proc{|controller| controller.current_user if controller}

  translates :description, :core_features, :release_note
  acts_as_paranoid

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :rates, class_name: Education::Rate.name, as: :rateable,
    dependent: :destroy
  has_many :members, class_name: Education::ProjectMember.name,
    foreign_key: :project_id, dependent: :destroy
  has_many :project_techniques, ->{with_deleted},
    class_name: Education::ProjectTechnique.name,
    foreign_key: :project_id, dependent: :destroy
  has_many :feedbacks, class_name: Education::Feedback.name,
    foreign_key: :project_id
  has_many :techniques, ->{with_deleted}, through: :project_techniques
  has_many :users, through: :members
  has_many :images, class_name: Education::Image.name, as: :imageable

  validates :name, presence: true,
    length: {maximum: Settings.education.project.max_name_length}
  validates :server_info, presence: true,
    length: {maximum: Settings.education.project.max_server_info_length}
  validates :plat_form, presence: true,
    length: {maximum: Settings.education.project.max_plat_form_length}
  validates :pm_url, presence: true, url: true
  validates :git_repo, presence: true, url: true

  validates :description, presence: true
  validates :core_features, presence: true
  validates :release_note, presence: true

  scope :newest, ->{order created_at: :desc}
  scope :relation_plat_form, ->plat_name do
    where plat_form: plat_name
  end
  scope :search_by_name, ->term do
    where("LOWER(name) LIKE :term", term: "%#{term.downcase}%")
  end
  scope :filter_by_technique, ->technique_name do
    joins(:techniques).where("education_techniques.name LIKE ?", technique_name)
  end
  scope :next, ->project do
    where("id > ?", project.id)
      .order(id: :asc)
      .limit(1)
  end
  scope :previous, ->project do
    where("id < ?", project.id)
      .order(id: :desc)
      .limit(1)
  end

  accepts_nested_attributes_for :images, allow_destroy: true
end
