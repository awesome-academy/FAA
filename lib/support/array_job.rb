class ArrayJob
  class << self
    def get_job job_object, user_object
      job_object.select do |job|
        (user_object.skills & job.skills).present?
      end
    end
  end
end
