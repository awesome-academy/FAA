module Supports
  class Candidate
    attr_reader :company, :job_ids

    def initialize company, job_ids
      @company = company
      @job_ids = job_ids
    end

    def candidates
      @company.candidates.includes(:user, :job).in_jobs(job_ids)
    end

    def active_jobs
      @company.jobs.active.newest
    end
  end
end
