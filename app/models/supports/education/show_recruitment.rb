module Supports::Education
  class ShowRecruitment
    attr_reader :related_recruitments, :popular_recruitments,
      :newest_recruitment

    def initialize recruitment
      @recruitment = recruitment
    end

    def related_recruitments
      Education::Post.related_by_category(@recruitment)
        .includes(:translations).created_desc
        .limit Settings.education.recruitments.related_recruitment_limit
    end

    def hot_recruitments
      Education::Post.list_recruitment.popular
        .includes(:translations)
        .limit Settings.education.recruitments.limit
    end

    def comments
      @recruitment.comments.includes(:user).newest
    end

    def all_tags
      Tag.select :name
    end

    def recruitment_tags
      @recruitment.tag_list
    end

    def get_rate user_id
      @recruitment.rates.find_by user_id: user_id
    end
  end
end
