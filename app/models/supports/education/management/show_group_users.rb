module Supports::Education::Management
  class ShowGroupUsers
    attr_reader :unadded_users, :added_users, :group

    def initialize params
      @params = params
    end

    def unadded_users
      User.not_in_object(group)
        .search(name_or_email_cont: @params[:user_search]).result
    end

    def added_users
      User.in_object(group)
        .search(name_or_email_cont: @params[:added_users_search]).result
    end

    def group
      Education::Group.find_by id: @params[:group]
    end

    def checked_input
      @params[:checked_input.to_s]
    end

    def added_checked_users
      @params[:added_checked_users.to_s]
    end
  end
end
