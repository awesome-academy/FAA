class Education::Category < ApplicationRecord
  acts_as_paranoid

  has_many :posts, ->{with_deleted},
    class_name: Education::Post.name, foreign_key: :category_id

  validates :name, presence: true,
    length: {maximum: Settings.education.category.max_length_title}

  enum category_type: {news: 0, recruitment: 1}

  scope :newest, ->{order created_at: :desc}
end
