class UserCertificate < ApplicationRecord
  belongs_to :user
  belongs_to :certificate

  validates :user, presence: true
  validates :certificate, presence: true
end
