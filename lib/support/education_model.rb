class EducationModel
  class << self
    def get_all
      ApplicationRecord.descendants.map(&:name)
        .select{|model| model if model.include? "Education::"}.sort
    end
  end
end
