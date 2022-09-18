require "test_helper"

class AppointmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @appointment = appointments(:one)
  end

  test "should get index" do
    get appointments_url, as: :json
    assert_response :success
  end

  test "should create appointment" do
    assert_difference("Appointment.count") do
      post appointments_url, params: { appointment: { admin_id: @appointment.admin_id, email: @appointment.email, end_date: @appointment.end_date, name: @appointment.name, start_data: @appointment.start_data, student_application_id: @appointment.student_application_id, student_id: @appointment.student_id, title: @appointment.title, uuid: @appointment.uuid } }, as: :json
    end

    assert_response :created
  end

  test "should show appointment" do
    get appointment_url(@appointment), as: :json
    assert_response :success
  end

  test "should update appointment" do
    patch appointment_url(@appointment), params: { appointment: { admin_id: @appointment.admin_id, email: @appointment.email, end_date: @appointment.end_date, name: @appointment.name, start_data: @appointment.start_data, student_application_id: @appointment.student_application_id, student_id: @appointment.student_id, title: @appointment.title, uuid: @appointment.uuid } }, as: :json
    assert_response :success
  end

  test "should destroy appointment" do
    assert_difference("Appointment.count", -1) do
      delete appointment_url(@appointment), as: :json
    end

    assert_response :no_content
  end
end
