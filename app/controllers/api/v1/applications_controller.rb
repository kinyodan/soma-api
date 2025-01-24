class Api::V1::ApplicationsController < ApplicationController
  before_action :set_application, only: %i[ show update destroy ]

  # GET /applications
  def index
    @applications = Application.paginate(
      page: params[:page], 
      per_page: params[:per_page] || 10
    )
    render json: @applications
  end

  # GET /applications/1
  def show
    render json: @application
  end

  # POST /applications
  def create
    @application = Application.new(application_params)

    if @application.save
      render json: @application, status: :created, location: @application
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /applications/1
  def update
    if @application.update(application_params)
      render json: @application
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  # DELETE /applications/1
  def destroy
    @application.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = Application.find(params[:id])
      return render json: { error: 'Application not found' }, status: :not_found unless @application
    end

    # Only allow a list of trusted parameters through.
    def application_params
      params.require(:application).permit(
        :uuid, :student_id, :ksce_cert, :passport, :school_leaving, :visa_refusals,
        :degree_certificate, :degree_transcript, :passport_copy, :recommendation_letters,
        :cv, :personal_statement, :confirmation_of_acceptance, :bank_statement,
        :previous_visa, :status, :upload_by, :application_admin, :progress_state,
        :progress_steps, :current_step, :current_agent_processing, :workflow_state,
        :workflow_status, :workflow_progress
      )
    end

end
