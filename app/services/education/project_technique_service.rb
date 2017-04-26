class Education::ProjectTechniqueService
  def initialize project, params
    @project = project
    @params = params
  end

  def add
    if @params[:technique_ids].present?
      technique_ids = @params[:technique_ids]
      Education::ProjectTechnique.transaction do
        technique_ids.each do |id|
          project_technique = @project.project_techniques
            .new technique_id: id
          project_technique.save!
        end
      end
    end
  end

  def update
    if @params[:technique_ids].present?
      Education::Technique.all.each do |technique|
        if @project.techniques.include? technique
          unless @params[:technique_ids].include? technique.id.to_s
            project_technique = @project.project_techniques
              .find_by(technique_id: technique.id)
            project_technique.destroy
          end
        elsif @params[:technique_ids].include? technique.id.to_s
          @project.project_techniques.create technique_id: technique.id
        end
      end
    else
      @project.project_techniques.destroy_all
    end
  end
end
