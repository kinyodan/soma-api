require 'rails_helper'

RSpec.describe StudentApplicationsController, type: :request do
  let(:student_application) { student_applications(:one) }

  describe "GET /student_applications" do
    it "returns a successful response" do
      get student_applications_path, as: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /student_applications" do
    it "creates a new student application" do
      expect {
        post student_applications_path, params: { student_application: { applicatio_admin: student_application.applicatio_admin, bank_statement: student_application.bank_statement, confirmation_of_acceptance: student_application.confirmation_of_acceptance, current_agent_processing: student_application.current_agent_processing, current_step: student_application.current_step, cv: student_application.cv, degree_certificate: student_application.degree_certificate, degree_transcript: student_application.degree_transcript, ksce_cert: student_application.ksce_cert, passport: student_application.passport, passport_copy: student_application.passport_copy, personal_statement: student_application.personal_statement, previous_visa: student_application.previous_visa, progress_state: student_application.progress_state, progress_steps: student_application.progress_steps, recommendation_letters: student_application.recommendation_letters, school_leaving: student_application.school_leaving, status: student_application.status, student_id: student_application.student_id, upload_by: student_application.upload_by, uuid: student_application.uuid, visa_refusals: student_application.visa_refusals, workflow_state: student_application.workflow_state, workflow_status: student_application.workflow_status, worklow_progress: student_application.worklow_progress } }, as: :json
      }.to change(StudentApplication, :count).by(1)
      
      expect(response).to have_http_status(:created)
    end
  end

  describe "GET /student_applications/:id" do
    it "shows the student application" do
      get student_application_path(student_application), as: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /student_applications/:id" do
    it "updates the student application" do
      patch student_application_path(student_application), params: { student_application: { applicatio_admin: student_application.applicatio_admin, bank_statement: student_application.bank_statement, confirmation_of_acceptance: student_application.confirmation_of_acceptance, current_agent_processing: student_application.current_agent_processing, current_step: student_application.current_step, cv: student_application.cv, degree_certificate: student_application.degree_certificate, degree_transcript: student_application.degree_transcript, ksce_cert: student_application.ksce_cert, passport: student_application.passport, passport_copy: student_application.passport_copy, personal_statement: student_application.personal_statement, previous_visa: student_application.previous_visa, progress_state: student_application.progress_state, progress_steps: student_application.progress_steps, recommendation_letters: student_application.recommendation_letters, school_leaving: student_application.school_leaving, status: student_application.status, student_id: student_application.student_id, upload_by: student_application.upload_by, uuid: student_application.uuid, visa_refusals: student_application.visa_refusals, workflow_state: student_application.workflow_state, workflow_status: student_application.workflow_status, worklow_progress: student_application.worklow_progress } }, as: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE /student_applications/:id" do
    it "deletes the student application" do
      expect {
        delete student_application_path(student_application), as: :json
      }.to change(StudentApplication, :count).by(-1)
      
      expect(response).to have_http_status(:no_content)
    end
  end
end
