module Supports::Education
  class ShowPost
    attr_reader :related_posts, :popular_posts, :newest_post

    def initialize post
      @post = post
    end

    def related_posts
      Education::Post.related_by_category(@post)
        .includes(:translations).created_desc
        .limit Settings.education.related_post.limit
    end

    def popular_posts
      Education::Post.popular.includes(:translations)
        .limit Settings.education.post.popular_posts_limit
    end

    def newest_post
      Education::Post.created_desc.includes(:translations)
        .limit Settings.education.post.newest_post_limit
    end

    def comments
      @post.comments.includes(:user).newest
    end

    def all_tags
      Tag.select :name
    end

    def post_tags
      @post.tag_list
    end

    def get_rate user_id
      @post.rates.find_by user_id: user_id
    end
  end
end
