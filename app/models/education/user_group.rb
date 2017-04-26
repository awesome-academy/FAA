class Education::UserGroup < ApplicationRecord
  belongs_to :user
  belongs_to :group, class_name: Education::Group.name
end
