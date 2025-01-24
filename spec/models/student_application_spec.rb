require 'rails_helper'

RSpec.describe StudentApplication, type: :model do
  let(:student_application) { create(:student_application) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(student_application).to be_valid
    end

    it "is not valid without an application admin" do
      student_application.applicatio_admin = nil
      expect(student_application).to_not be_valid
    end

    it "is not valid without a student_id" do
      student_application.student_id = nil
      expect(student_application).to_not be_valid
    end

    it "is not valid without a status" do
      student_application.status = nil
      expect(student_application).to_not be_valid
    end

    it "is not valid without a uuid" do
      student_application.uuid = nil
      expect(student_application).to_not be_valid
    end
  end

  describe "associations" do
    it "belongs to a student" do
      expect(student_application).to respond_to(:student)
    end

    it "has many documents" do
      expect(student_application).to respond_to(:documents)
    end
  end

  describe "methods" do
    describe "#application_status" do
      it "returns the application status" do
        expect(student_application.application_status).to eq(student_application.status)
      end
    end

    describe "#workflow_progress" do
      it "returns the workflow progress" do
        expect(student_application.workflow_progress).to eq(student_application.worklow_progress)
      end
    end
  end

  describe "scopes" do
    let!(:student_application_1) { create(:student_application, status: 'pending') }
    let!(:student_application_2) { create(:student_application, status: 'approved') }

    it "returns pending applications" do
      expect(StudentApplication.pending).to include(student_application_1)
      expect(StudentApplication.pending).to_not include(student_application_2)
    end

    it "returns approved applications" do
      expect(StudentApplication.approved).to include(student_application_2)
      expect(StudentApplication.approved).to_not include(student_application_1)
    end
  end
end

