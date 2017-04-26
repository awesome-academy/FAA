module Supports::Education
  class UserImage
    attr_reader :new_image, :user_education_images

    def initialize current_user
      @user = current_user
    end

    def new_image
      @user.education_images.new
    end

    def user_education_images
      @user.education_images
    end

    def tags
      Tag.select :name
    end
  end
end
