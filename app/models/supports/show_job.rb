module Supports
  class ShowJob
    attr_reader :job, :company, :benefits, :members, :team_introduction,
      :hiring_types, :published_date, :qualified_profile

    delegate :benefits, :founder_on, to: :company, prefix: true

    def initialize job, user
      @job = job
      @user = user
    end

    def company
      @job.company
    end

    def members
      company.users.includes :avatar
    end

    def jobs_company
      company.jobs.limit(4)
    end

    def company_address
      company.addresses
    end

    def team_introduction
      @job.team_introductions.includes :images
    end

    def count_candidates
      @job.candidates.count
    end

    def hiring_types
      @job.hiring_types
    end

    def job_skills
      @job.skills
    end

    def published_date
      @job.created_at.to_date
    end

    def recommend
      User.recommend(@job).includes(:avatar)
    end

    def qualified_profile?
      requests = JSON.parse(@job.profile_requests).to_a
      (education? requests) && (portfolio? requests) && (introduce? requests) &&
        (requests.exclude?("ambition") || @user.info_user.ambition.present?)
    end

    private

    def education? requests
      requests.exclude?("user_educations") || @user.user_educations.any?
    end

    def portfolio? requests
      requests.exclude?("user_portfolios") || @user.user_portfolios.any?
    end

    def introduce? requests
      requests.exclude?("introduce") || @user.info_user.introduce.present?
    end
  end
end
