class Api::V1::AppointmentsController < BaseController
  before_action :set_appointment, only: %i[ show update destroy ]

  # GET /appointments
  def index
    @appointments = Appointment.all

    @response = { status: true, message: 'Student Appointments Listed',data: @appointments }
    render json: @response
  end

  # GET /appointments/1
  def show
    render json: @appointment
  end

  # POST /appointments
  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      render json: @appointment, status: :created
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /appointments/1
  def update
    if @appointment.update(appointment_params)
      render json: @appointment
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /appointments/1
  def destroy
    @appointment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def appointment_params
      params.permit(:start_date_id, :start,  :end_date_id, :end, :timed, :color, :student_id, :email, :student_application_id, :uuid, :name, :title, :admin_id)
    end
end
