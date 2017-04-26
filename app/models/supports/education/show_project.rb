module Supports::Education
  class ShowProject
    attr_reader :project, :comments, :user_ids, :added_users,
      :users, :member_position

    def initialize project, comments, params
      @project = project
      @comments = comments
      @params = params
    end

    def project_members
      @project.members.order(:position).includes :user
    end

    def relations
      Education::Project.relation_plat_form(@project.plat_form)
        .newest.includes(:images).limit Settings.education.related_project.limit
    end

    def rand_project_id
      Education::Project.ids.sample
    end

    def user_ids
      user_ids_temp = []
      if @params[:user_ids].present?
        @params[:user_ids].each do |id|
          user_ids_temp << id.to_i
        end
      end
      user_ids_temp
    end

    def added_users
      @project.users.by_active.search(name_or_email_cont:
        @params[:search_added_members]).result
    end

    def users
      User.by_active.not_in_object(@project)
        .search(name_or_email_cont: @params[:user_search]).result
    end

    def member_position
      user_ids_temp = []
      if @params[:member_position].present?
        @params[:member_position].each do |id|
          user_ids_temp << id.to_i
        end
      end
      user_ids_temp
    end

    def get_rate user_id
      @project.rates.find_by user_id: user_id
    end
  end
end
