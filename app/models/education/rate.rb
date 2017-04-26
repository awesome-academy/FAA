class Education::Rate < ApplicationRecord
  belongs_to :user
  belongs_to :rateable, polymorphic: true

  validates :rate, presence: true
end
