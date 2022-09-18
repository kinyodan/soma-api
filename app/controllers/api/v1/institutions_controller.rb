class Api::V1::InstitutionsController < ApplicationController
  before_action :set_institution, only: %i[ show update destroy ]

  # GET /institutions
  def index
    @institutions = Institution.all
    @response = { status: true, message: "Institutions listed",data: @institutions }
    render json: @response
  end

  # GET /institutions/1
  def show
    @response = { status: true, message: "Institution item listed",data: @institution }
    render json: @response
  end

  # POST /institutions
  def create
    @institution = Institution.new(institution_params)

    if @institution.save
      @response = { status: true, message: "Institution item created",data: @institution }
      render json: @response, status: :created
    else
      @response = { status: false, message: " Error creating Institution",data: @institution.errors }
      render json: @response, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /institutions/1
  def update
    if @institution.update(institution_params)
      render json: @institution
    else
      @response = { status: false, message: "Error updating Institution",data: @institution.errors }
      render json: @response, status: :unprocessable_entity
    end
  end

  # DELETE /institutions/1
  def destroy
    @institution.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_institution
      @institution = Institution.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def institution_params
      params.permit(:name, :country_code, :website)
    end
end
