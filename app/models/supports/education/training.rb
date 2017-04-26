module Supports::Education
  class Training
    attr_reader :techniques, :trainings

    def initialize param_training, param_technique, param_page
      @param_training ||= param_training
      @param_technique = param_technique
      @param_page = param_page
    end

    def techniques
      Education::Technique.with_deleted.all
    end

    def search
      @search = Education::Training.search @param_training
    end

    def trainings
      if @param_technique
        Education::Training.filter_by_technique(@param_technique)
          .includes :translations
      else
        Education::Training.search(name_cont: @param_training).result
          .includes :images, :translations
      end
    end

    def trainings_for_manager
      trainings.newest.page(@param_page)
        .per Settings.education.trainings.per_page
    end

    def trainings_for_guest
      trainings.newest.includes(:techniques).page(@param_page)
        .per Settings.education.trainings.per_page
    end
  end
end
