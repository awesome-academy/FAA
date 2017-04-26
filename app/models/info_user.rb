class InfoUser < ApplicationRecord
  belongs_to :user

  validates :introduce,
    length: {maximum: Settings.info_users.max_length_introduce}
  validates :ambition,
    length: {maximum: Settings.info_users.max_length_ambition}
  validates :quote,
    length: {maximum: Settings.info_users.max_length_quote}
end
