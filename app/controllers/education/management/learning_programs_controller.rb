class Education::Management::LearningProgramsController <
  Education::Management::BaseController
  load_and_authorize_resource class: Education::LearningProgram
  before_action :find_learning_program, only: :update

  def index
    @learning_programs = Education::LearningProgram.all
  end

  def update
    if @learning_program.update_attributes learning_program_params
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to education_management_learning_programs_path
  end

  private

  def learning_program_params
    params.require(:education_learning_program).permit :id, :name, :description
  end

  def find_learning_program
    @learning_program = Education::LearningProgram.find_by id: params[:id]
    unless @learning_program
      flash[:danger] = t ".not_found"
      redirect_to education_management_learning_programs_path
    end
  end
end
