require 'rails_helper'

RSpec.describe Api::V1::ApplicationsController, type: :request do
  let!(:application) { create(:application) } # Assumes you have a FactoryBot factory for Application

  describe "GET /applications" do
    it "returns a successful response" do
      get applications_path, as: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /applications" do
    let(:valid_attributes) do
      {
        application: {
          applicatio_admin: application.applicatio_admin,
          bank_statement: application.bank_statement,
          confirmation_of_acceptance: application.confirmation_of_acceptance,
          current_agent_processing: application.current_agent_processing,
          current_step: application.current_step,
          cv: application.cv,
          degree_certificate: application.degree_certificate,
          degree_transcript: application.degree_transcript,
          ksce_cert: application.ksce_cert,
          passport: application.passport,
          passport_copy: application.passport_copy,
          personal_statement: application.personal_statement,
          previous_visa: application.previous_visa,
          progress_state: application.progress_state,
          progress_steps: application.progress_steps,
          recommendation_letters: application.recommendation_letters,
          school_leaving: application.school_leaving,
          status: application.status,
          student_id: application.student_id,
          upload_by: application.upload_by,
          uuid: application.uuid,
          visa_refusals: application.visa_refusals,
          workflow_state: application.workflow_state,
          workflow_status: application.workflow_status,
          worklow_progress: application.worklow_progress
        }
      }
    end

    it "creates a new application" do
      expect {
        post applications_path, params: valid_attributes, as: :json
      }.to change(Application, :count).by(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe "GET /applications/:id" do
    it "returns a successful response" do
      get application_path(application), as: :json
      expect(response).to have_http_status(:success)
    end
  end

  # Uncomment and implement if needed
  # describe "PATCH /applications/:id" do
  #   let(:updated_attributes) do
  #     {
  #       application: {
  #         current_step: "Updated Step"
  #       }
  #     }
  #   end

  #   it "updates the application" do
  #     patch application_path(application), params: updated_attributes, as: :json
  #     expect(response).to have_http_status(:success)
  #     expect(application.reload.current_step).to eq("Updated Step")
  #   end
  # end

  describe "DELETE /applications/:id" do
    it "destroys the application" do
      expect {
        delete application_path(application), as: :json
      }.to change(Application, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
