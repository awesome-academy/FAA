class Education::Permission < ApplicationRecord
  belongs_to :group, class_name: Education::Group

  serialize :optional, Hash
end
