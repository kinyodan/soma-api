require 'rails_helper'

RSpec.describe Appointment, type: :model do
  let(:appointment) { create(:appointment) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(appointment).to be_valid
    end

    it "is not valid without a name" do
      appointment.name = nil
      expect(appointment).to_not be_valid
    end

    it "is not valid without a start date" do
      appointment.start_data = nil
      expect(appointment).to_not be_valid
    end

    it "is not valid without an end date" do
      appointment.end_date = nil
      expect(appointment).to_not be_valid
    end

    it "is not valid without a student" do
      appointment.student_id = nil
      expect(appointment).to_not be_valid
    end
  end

  describe "associations" do
    it "belongs to a student" do
      expect(appointment).to respond_to(:student)
    end

    it "belongs to a student_application" do
      expect(appointment).to respond_to(:student_application)
    end
  end

  describe "scopes" do
    let!(:future_appointments) { create_list(:appointment, 3, start_data: 2.days.from_now) }
    let!(:past_appointments) { create_list(:appointment, 2, start_data: 2.days.ago) }

    it "returns only future appointments" do
      expect(Appointment.future).to match_array(future_appointments)
    end
  end

  describe "#some_method" do
    it "does something specific" do
      # test the behavior of a custom method in the Appointment model, if needed
    end
  end
end
