class Education::TrainingTechniqueService
  def initialize training, params
    @training = training
    @params = params
  end

  def add
    if @params[:technique_ids].present?
      technique_ids = @params[:technique_ids]
      Education::TrainingTechnique.transaction do
        technique_ids.each do |id|
          training_technique = @training.training_techniques
            .new technique_id: id
          training_technique.save!
        end
      end
    end
  end

  def update
    if @params[:technique_ids].present?
      Education::Technique.all.each do |technique|
        if @training.techniques.include? technique
          unless @params[:technique_ids].include? technique.id.to_s
            training_technique = @training.training_techniques
              .find_by(technique_id: technique.id)
            training_technique.destroy
          end
        elsif @params[:technique_ids].include? technique.id.to_s
          @training.training_techniques.create technique_id: technique.id
        end
      end
    else
      @training.training_techniques.destroy_all
    end
  end
end
