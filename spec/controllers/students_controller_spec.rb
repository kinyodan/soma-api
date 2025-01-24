require 'rails_helper'

RSpec.describe StudentsController, type: :request do
  let(:student) { students(:one) }

  describe "GET /students" do
    it "returns a successful response" do
      get students_path, as: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /students" do
    it "creates a new student" do
      expect {
        post students_path, params: { student: { country_code: student.country_code, country_id: student.country_id, email: student.email, first_name: student.first_name, last_name: student.last_name, location: student.location, phone: student.phone, second_name: student.second_name } }, as: :json
      }.to change(Student, :count).by(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe "GET /students/:id" do
    it "shows the student" do
      get student_path(student), as: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /students/:id" do
    it "updates the student" do
      patch student_path(student), params: { student: { country_code: student.country_code, country_id: student.country_id, email: student.email, first_name: student.first_name, last_name: student.last_name, location: student.location, phone: student.phone, second_name: student.second_name } }, as: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE /students/:id" do
    it "deletes the student" do
      expect {
        delete student_path(student), as: :json
      }.to change(Student, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end

