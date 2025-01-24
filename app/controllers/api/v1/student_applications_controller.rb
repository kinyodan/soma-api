class Api::V1::StudentApplicationsController < BaseController
  before_action :set_student_application, only: %i[show update destroy soft_destroy]

  def index
    student_applications = StudentApplication.paginate(
      page: params[:page],
      per_page: params[:per_page] || 10
    )
  
    render_response(
      status: true,
      message: 'Student applications listed successfully',
      data: student_applications,
      meta: {
        current_page: student_applications.current_page,
        total_pages: student_applications.total_pages,
        total_count: student_applications.total_count,
        per_page: student_applications.limit_value
      }
    )
  end

  def student_applications_list
    @applications = get_student_applications
    render_response(status: true, message: 'Student applications listed', data: @applications)
  end

  def show
    @student = Student.where(id: @student_application.student_id)
    render_response(
      status: true,
      message: 'Student details listed',
      data: { applications: @student_application, student: @student }
    )
  end

  def create
    @student_present = Student.find_by(id: student_application_params[:student_id])
    if @student_present
      @student_application = StudentApplication.new(student_application_params)
      @student_application.student_id = @student_present.id

      if @student_application.save
        @applications = get_student_applications
        render_response(status: true, message: 'Student application created', data: @applications, status_code: :created)
      else
        render json: @student_application.errors, status: :unprocessable_entity
      end
    else
      render_response(status: false, message: 'Missing student ID', status_code: :unprocessable_entity)
    end
  end

  def update
    if @student_application.update(student_application_params)
      render_response(status: true, message: 'Student application updated', data: @student_application)
    else
      render json: @student_application.errors, status: :unprocessable_entity
    end
  end

  def soft_destroy
    if student_application_params[:is_deleted].present? && @student_application.update(is_deleted: student_application_params[:is_deleted])
      render_response(status: true, message: 'Student application deleted', data: @student_application)
    else
      render json: @student_application.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @student_application.destroy
      render_response(status: true, message: 'Student Application Deleted', data: {})
    end
  end

  private

  def set_student_application
    @student_application = StudentApplication.find_by_uuid(params[:id])
  end

  def get_student_applications
    student = if params[:uuid]
      Student.find_by(uuid: params[:uuid])
    else
      Student.find_by(id: params[:student_id])
    end

    return StudentApplication.where(student_id: student.id) if student

    render json: { status: false, message: 'Student not found' }, status: :not_found and return
  end

  def student_application_params
    params.permit(
      :id, :uuid, :student_id, :ksce_cert, :passport, :school_leaving,
      :visa_refusals, :degree_certificate, :degree_transcript,
      :passport_copy, :recommendation_letters, :cv,
      :personal_statement, :confirmation_of_acceptance,
      :bank_statement, :previous_visa, :status,
      :upload_by, :application_admin, :application_form,
      :progress_state, :progress_steps, :current_step,
      :current_agent_processing, :workflow_state, :workflow_status,
      :worklow_progress, :name, :institution_name, :institution_email,
      :institution_phone, :institution_id, :application_form_template_url,
      :application_form, :fileCount, :is_deleted
    )
  end

  def render_response(status:, message:, data: nil, meta: nil, status_code: :ok)
    response = {
      status: status,
      message: message,
      data: data,
      meta: meta
    }.compact

    render json: response, status: status_code
  end
end
