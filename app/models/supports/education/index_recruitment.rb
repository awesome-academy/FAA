module Supports::Education
  class IndexRecruitment
    attr_reader :recruitments, :tags

    def initialize param_page, param_q
      @param_q ||= param_q
      @param_page = param_page
    end

    def categories
      Education::Category.all
    end

    def search
      Education::Post.search @param_q
    end

    def recruitments
      search = Education::Post.list_recruitment.search(@param_q)
      recruitments = search.result(distinct: true).includes :user, :category
      recruitments.includes(:translations).page(@param_page)
        .per Settings.education.recruitments.per_page
    end

    def hot_recruitments
      Education::Post.list_recruitment.popular
        .includes(:translations)
        .limit Settings.education.recruitments.limit
    end

    def tags
      Tag.select :name
    end
  end
end
