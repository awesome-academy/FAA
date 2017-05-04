class Education::Post < ApplicationRecord
  include PublicActivity::Model
  tracked owner: proc{|controller| controller.current_user if controller}

  translates :title
  acts_as_paranoid
  acts_as_taggable_on :tags

  belongs_to :category, ->{with_deleted}, class_name: Education::Category.name
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :rates, class_name: Education::Rate.name, as: :rateable,
    dependent: :destroy

  validates :title, presence: true,
    length: {maximum: Settings.education.post.title_max_length,
      minimum: Settings.education.post.title_min_length}
  validates :user_id, presence: true
  validates :category_id, presence: true
  validates :content, presence: true,
    length: {minimum: Settings.education.post.content_min_length}

  delegate :name, to: :user, prefix: true
  delegate :avatar, to: :user, prefix: true

  enum post_type: {news: 0, recruitment: 1}

  scope :created_desc, ->{order created_at: :desc}
  scope :related_by_category, ->post do
    where "category_id = #{post.category_id} AND id != #{post.id}"
  end
  scope :popular, ->{order comments_count: :desc}

  scope :by_category_id, ->category_id do
    where category_id: category_id if category_id.present?
  end

  scope :by_user, ->user_id do
    where user_id: user_id if user_id.present?
  end

  scope :by_title, ->title do
    with_translations(I18n.locale)
      .where("LOWER(title) LIKE :title", title: "%#{title.downcase}%")
  end
end
