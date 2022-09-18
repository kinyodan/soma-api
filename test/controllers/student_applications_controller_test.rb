require "test_helper"

class StudentApplicationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @student_application = student_applications(:one)
  end

  test "should get index" do
    get student_applications_url, as: :json
    assert_response :success
  end

  test "should create student_application" do
    assert_difference("StudentApplication.count") do
      post student_applications_url, params: { student_application: { applicatio_admin: @student_application.applicatio_admin, bank_statement: @student_application.bank_statement, confirmation_of_acceptance: @student_application.confirmation_of_acceptance, current_agent_processing: @student_application.current_agent_processing, current_step: @student_application.current_step, cv: @student_application.cv, degree_certificate: @student_application.degree_certificate, degree_transcript: @student_application.degree_transcript, ksce_cert: @student_application.ksce_cert, passport: @student_application.passport, passport_copy: @student_application.passport_copy, personal_statement: @student_application.personal_statement, previous_visa: @student_application.previous_visa, progress_state: @student_application.progress_state, progress_steps: @student_application.progress_steps, recommendation_letters: @student_application.recommendation_letters, school_leaving: @student_application.school_leaving, status: @student_application.status, student_id: @student_application.student_id, upload_by: @student_application.upload_by, uuid: @student_application.uuid, visa_refusals: @student_application.visa_refusals, workflow_state: @student_application.workflow_state, workflow_status: @student_application.workflow_status, worklow_progress: @student_application.worklow_progress } }, as: :json
    end

    assert_response :created
  end

  test "should show student_application" do
    get student_application_url(@student_application), as: :json
    assert_response :success
  end

  test "should update student_application" do
    patch student_application_url(@student_application), params: { student_application: { applicatio_admin: @student_application.applicatio_admin, bank_statement: @student_application.bank_statement, confirmation_of_acceptance: @student_application.confirmation_of_acceptance, current_agent_processing: @student_application.current_agent_processing, current_step: @student_application.current_step, cv: @student_application.cv, degree_certificate: @student_application.degree_certificate, degree_transcript: @student_application.degree_transcript, ksce_cert: @student_application.ksce_cert, passport: @student_application.passport, passport_copy: @student_application.passport_copy, personal_statement: @student_application.personal_statement, previous_visa: @student_application.previous_visa, progress_state: @student_application.progress_state, progress_steps: @student_application.progress_steps, recommendation_letters: @student_application.recommendation_letters, school_leaving: @student_application.school_leaving, status: @student_application.status, student_id: @student_application.student_id, upload_by: @student_application.upload_by, uuid: @student_application.uuid, visa_refusals: @student_application.visa_refusals, workflow_state: @student_application.workflow_state, workflow_status: @student_application.workflow_status, worklow_progress: @student_application.worklow_progress } }, as: :json
    assert_response :success
  end

  test "should destroy student_application" do
    assert_difference("StudentApplication.count", -1) do
      delete student_application_url(@student_application), as: :json
    end

    assert_response :no_content
  end
end
