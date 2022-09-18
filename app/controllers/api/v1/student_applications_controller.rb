class Api::V1::StudentApplicationsController < ApplicationController
  before_action :set_student_application, only: %i[show update destroy soft_destroy]

  # GET /student_applications
  def index
    @student_applications = StudentApplication.all
    @response = { status: true, message: 'Student applications listed ', data: @student_applications }
    render json: @response
  end

  def student_applications_list
    @applications = get_student_applications
    @response = { status: true, message: 'Student applications listed ', data: @applications }
    render json: @response
  end

  # GET /student_applications/1
  def show
    @student = Student.where(id: @student_application.student_id)
    @response = { status: true, message: 'Student details Listed', applications: @student_application, student: @student }
    render json: @response
  end

  # POST /student_applications
  def create
    @student_present = Student.find(student_application_params[:student_id])
    if @student_present
      @student_application = StudentApplication.new(student_application_params)
      @student_application.student_id = @student_present.id if @student_present
      @applications = get_student_applications
      @response = { status: true, message: 'Student application created', data: @applications }
      @student_application.student_id = @student_present.id
      if @student_application.save
        render json: @response, status: :created
      else
        render json: @student_application.errors, status: :unprocessable_entity
      end
    else
      render json: { message: 'missing student ID', status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /student_applications/1
  def update
    if @student_application.update(student_application_params)
      @response = { status: true, message: 'Student application updated', data: @student_application }
      render json: @response
    else
      render json: @student_application.errors, status: :unprocessable_entity
    end
  end

  # SOFT DELETE /student_applications/1
  def soft_destroy
    if @student_application.update_attribute(:is_deleted, student_application_params[:is_deleted])
      @response = { status: true, message: 'Student application deleted',data:@student_applications }
      render json: @response
    else
      render json: @student_application.errors, status: :unprocessable_entity
    end
  end

  # DELETE /student_applications/1
  def destroy
    if @student_application.destroy
      @response = { status: true, message: 'Student Application Deleted', data: {} }
      render json: @response
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_student_application
    @student_application = StudentApplication.find_by_uuid(params[:id])
  end

  def get_student_applications
    if params[:uuid]
      get_student = Student.where(uuid: params[:uuid]).first
      @applications = StudentApplication.where(student_id: get_student.id )
    else
      @applications = StudentApplication.where(student_id: params[:student_id] )
    end

    return  @applications
  end

  # Only allow a list of trusted parameters through.
  def student_application_params
    params.permit(:id,
                  :uuid,
                  :student_id,
                  :ksce_cert,
                  :passport,
                  :school_leaving,
                  :visa_refusals,
                  :degree_certificate,
                  :degree_transcript,
                  :passport_copy,
                  :recommendation_letters,
                  :cv,
                  :personal_statement,
                  :confirmation_of_acceptance,
                  :bank_statement,
                  :previous_visa,
                  :status,
                  :upload_by,
                  :application_admin,
                  :application_form,
                  :progress_state,
                  :progress_steps,
                  :current_step,
                  :current_agent_processing,
                  :workflow_state,
                  :workflow_status,
                  :worklow_progress,
                  :name,
                  :institution_name,
                  :institution_email,
                  :institution_phone,
                  :institution_id,
                  :application_form_template_url,
                  :application_form,
                  :fileCount,
                  :is_deleted )
  end
end
