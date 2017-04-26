class Employer::CandidatesController < Employer::BaseController
  load_resource :company

  def index
    if params[:select].blank?
      params[:job_id] = @company.jobs.pluck(:id)
    else
      params[:job_id] = params[:select]
    end
    @object = Supports::Candidate.new @company, params[:job_id]
    respond_to do |format|
      if request.xhr?
        format.html do
          render partial: "candidate",
          locals: {candidates: @object.candidates}
        end
      else
        format.html
      end
    end
  end
end
