require 'rails_helper'

RSpec.describe AppointmentsController, type: :request do
  let!(:appointment) { create(:appointment) } 

  describe "GET /appointments" do
    it "returns a successful response" do
      get appointments_path, as: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /appointments" do
    let(:valid_params) do
      {
        appointment: {
          admin_id: appointment.admin_id,
          email: appointment.email,
          end_date: appointment.end_date,
          name: appointment.name,
          start_data: appointment.start_data,
          student_application_id: appointment.student_application_id,
          student_id: appointment.student_id,
          title: appointment.title,
          uuid: appointment.uuid
        }
      }
    end

    it "creates a new appointment" do
      expect {
        post appointments_path, params: valid_params, as: :json
      }.to change(Appointment, :count).by(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe "GET /appointments/:id" do
    it "returns the appointment" do
      get appointment_path(appointment), as: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /appointments/:id" do
    let(:update_params) do
      {
        appointment: {
          admin_id: appointment.admin_id,
          email: appointment.email,
          end_date: appointment.end_date,
          name: appointment.name,
          start_data: appointment.start_data,
          student_application_id: appointment.student_application_id,
          student_id: appointment.student_id,
          title: "Updated Title",
          uuid: appointment.uuid
        }
      }
    end

    it "updates the appointment" do
      patch appointment_path(appointment), params: update_params, as: :json
      expect(response).to have_http_status(:success)
      expect(appointment.reload.title).to eq("Updated Title")
    end
  end

  describe "DELETE /appointments/:id" do
    it "destroys the appointment" do
      expect {
        delete appointment_path(appointment), as: :json
      }.to change(Appointment, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
