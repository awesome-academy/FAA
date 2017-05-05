module Supports::Education
  class IndexPost
    attr_reader :categories, :news

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
      Education::Post.news.search @param_q
    end

    def news
      search = Education::Post.news.search(content_cont: @param_q)
      news = search.result(distinct: true).includes :user, :category
      news = news.by_user @param_user if @param_user.present?
      news = news.by_category_id @param_category if @param_category.present?
      news.created_desc.includes(:translations).page(@param_page)
        .per Settings.education.trainings.per_page
    end
  end
end
