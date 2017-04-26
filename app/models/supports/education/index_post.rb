module Supports::Education
  class IndexPost
    attr_reader :categories, :posts

    def initialize param_q, param_page, param_category, param_user
      @param_q ||= param_q
      @param_page = param_page
      @param_category = param_category
      @param_user = param_user
    end

    def categories
      Education::Category.all
    end

    def search
      Education::Post.search @param_q
    end

    def posts
      search = Education::Post.search(content_cont: @param_q)
      posts = search.result(distinct: true).includes :user, :category
      posts = posts.by_user @param_user if @param_user.present?
      posts = posts.by_category_id @param_category if @param_category.present?
      posts.created_desc.includes(:translations).page(@param_page)
        .per Settings.education.trainings.per_page
    end
  end
end
