require 'rails_helper'

RSpec.describe Application, type: :model do
  let(:application) { create(:application) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(application).to be_valid
    end

    it "is not valid without a student_id" do
      application.student_id = nil
      expect(application).to_not be_valid
    end

    it "is not valid without a current_step" do
      application.current_step = nil
      expect(application).to_not be_valid
    end

    it "is not valid without a status" do
      application.status = nil
      expect(application).to_not be_valid
    end
  end

  describe "associations" do
    it "belongs to a student" do
      expect(application).to respond_to(:student)
    end

    # Add other associations like workflow state or any related models if applicable
    it "has many recommendation_letters" do
      expect(application).to respond_to(:recommendation_letters)
    end
  end

  describe "scopes" do
    let!(:approved_applications) { create_list(:application, 3, status: 'approved') }
    let!(:pending_applications) { create_list(:application, 2, status: 'pending') }

    it "returns only approved applications" do
      expect(Application.approved).to match_array(approved_applications)
    end

    it "returns only pending applications" do
      expect(Application.pending).to match_array(pending_applications)
    end
  end

  describe "methods" do
    describe "#status_label" do
      it "returns the correct label based on status" do
        application.status = "approved"
        expect(application.status_label).to eq("Application Approved")
        
        application.status = "pending"
        expect(application.status_label).to eq("Application Pending")
      end
    end
  end
end

