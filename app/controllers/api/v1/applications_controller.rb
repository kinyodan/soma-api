class Api::V1::ApplicationsController < ApplicationController
  before_action :set_application, only: %i[ show update destroy ]
  # before_action :verify_authenticated

  def verify_authenticated
    header_params = eval(request.headers['HTTP_AUTHORIZATION'])
    decoded_response = decrypt(header_params[:token], 'hmac_secret_key', 'HS256')

    if (@user = User.find_by_jti(decoded_response[:jti]))
      render json: { status: true , message: 'User Authenticated ' }
    else
      render json: { data: :unauthorized, status: :created , message:'user failed logged in' }
    end
  end

  # GET /applications
  def index
    @applications = Application.all

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
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = Application.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def application_params
      params.require(:application).permit(:uuid, :student_id, :ksce_cert, :passport, :school_leaving, :visa_refusals, :degree_certificate, :degree_transcript, :passport_copy, :recommendation_letters, :cv, :personal_statement, :confirmation_of_acceptance, :bank_statement, :previous_visa, :status, :upload_by, :applicatio_admin, :progress_state, :progress_steps, :current_step, :current_agent_processing, :workflow_state, :workflow_status, :worklow_progress)
    end

    def encrypt(payload, salt, algo = 'HS256')
      JWT.encode payload, salt, algo
    end

    def decrypt(token, salt, algo = 'HS256')
      decrypted_token = JWT.decode token, salt, algo
      decrypted_token.first.deep_symbolize_keys rescue {}
    end

end
