class Api::V1::AppointmentsController < BaseController
  before_action :set_appointment, only: %i[show update destroy]

  # GET /appointments
  def index
    appointments = Appointment.paginate(
      page: params[:page], 
      per_page: params[:per_page] || 10
    )
    render json: {
      status: true,
      message: 'Student appointments listed successfully',
      data: appointments
    }
  end

  # GET /appointments/1
  def show
    render json: {
      status: true,
      message: 'Appointment details retrieved successfully',
      data: @appointment
    }
  end

  # POST /appointments
  def create
    appointment = Appointment.new(appointment_params)

    if appointment.save
      render json: {
        status: true,
        message: 'Appointment created successfully',
        data: appointment
      }, status: :created
    else
      render json: {
        status: false,
        message: 'Failed to create appointment',
        errors: appointment.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /appointments/1
  def update
    if @appointment.update(appointment_params)
      render json: {
        status: true,
        message: 'Appointment updated successfully',
        data: @appointment
      }
    else
      render json: {
        status: false,
        message: 'Failed to update appointment',
        errors: @appointment.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # DELETE /appointments/1
  def destroy
    @appointment.destroy
    render json: {
      status: true,
      message: 'Appointment deleted successfully'
    }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_appointment
    @appointment = Appointment.find_by(id: params[:id])
    return render json: { status: false, message: 'Appointment not found' }, status: :not_found unless @appointment
  end

  # Only allow a list of trusted parameters through.
  def appointment_params
    params.permit(
      :start_date_id, :start, :end_date_id, :end, :timed, :color, 
      :student_id, :email, :student_application_id, :uuid, 
      :name, :title, :admin_id
    )
  end
end
