class Api::V1::StudentsController < BaseController
  before_action :set_student, only: [:update, :destroy]
  before_action :set_student_by_uuid, only: [:show, :update, :destroy, :applications]

  # GET /students
  def index
    students = Student.paginate(
      page: params[:page], 
      per_page: params[:per_page] || 10
    )
    render json: { data: students, status: true, message: "Students listed successfully" }
  end

  # GET /students/:id
  def show
    applications = @student_by_uuid.student_applications
    render json: {
      status: true,
      message: "Student details listed successfully",
      student: @student_by_uuid,
      applications: applications
    }
  end

  # GET /students/:id/applications
  def applications
    applications = @student_by_uuid.student_applications
    render json: {
      status: true,
      message: "Applications listed successfully",
      student: @student_by_uuid,
      applications: applications
    }
  end

  # POST /students
  def create
    student = Student.find_by(email: student_params[:email])
    user = User.find_by(email: student_params[:email])

    if student || user
      render json: { status: false, message: "Email already exists" }, status: :unprocessable_entity
    else
      new_student = Student.new(student_params)
      if new_student.save
        render json: {
          status: true,
          message: "Sign up successful",
          data: new_student
        }, status: :created
      else
        render json: {
          status: false,
          message: "Failed to create student",
          errors: new_student.errors.full_messages
        }, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /students/:id
  def update
    if @student.update(student_params)
      render json: { status: true, message: "Student updated successfully", data: @student }
    else
      render json: {
        status: false,
        message: "Failed to update student",
        errors: @student.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # DELETE /students/:id
  def destroy
    if @student.destroy
      render json: { status: true, message: "Student deleted successfully" }
    else
      render json: {
        status: false,
        message: "Failed to delete student",
        errors: @student.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  private

  def set_student
    @student = Student.find_by(id: params[:id])
    render json: { status: false, message: "Student not found" }, status: :not_found unless @student
  end

  def set_student_by_uuid
    @student_by_uuid = Student.find_by(uuid: params[:id])
    unless @student_by_uuid
      render json: { status: false, message: "Student not found" }, status: :not_found
    end
  end

  def student_params
    params.require(:student).permit(
      :first_name, :second_name, :last_name, :phone, :email, :location,
      :country_id, :country_code, :status, :password, :confirm_password
    )
  end
end

