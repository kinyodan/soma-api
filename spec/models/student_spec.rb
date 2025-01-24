require 'rails_helper'

RSpec.describe Student, type: :model do
  let(:student) { create(:student) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(student).to be_valid
    end

    it "is not valid without a country_code" do
      student.country_code = nil
      expect(student).to_not be_valid
    end

    it "is not valid without an email" do
      student.email = nil
      expect(student).to_not be_valid
    end

    it "is not valid without a first_name" do
      student.first_name = nil
      expect(student).to_not be_valid
    end

    it "is not valid without a last_name" do
      student.last_name = nil
      expect(student).to_not be_valid
    end

    it "is not valid without a phone number" do
      student.phone = nil
      expect(student).to_not be_valid
    end
  end

  describe "associations" do
    it "belongs to a country" do
      expect(student).to respond_to(:country)
    end

    it "has many student applications" do
      expect(student).to respond_to(:student_applications)
    end
  end

  describe "methods" do
    describe "#full_name" do
      it "returns the full name of the student" do
        expect(student.full_name).to eq("#{student.first_name} #{student.last_name}")
      end
    end
  end

  describe "scopes" do
    let!(:student_1) { create(:student, first_name: 'John') }
    let!(:student_2) { create(:student, first_name: 'Jane') }

    it "returns students with a specific first name" do
      expect(Student.with_first_name('John')).to include(student_1)
      expect(Student.with_first_name('John')).to_not include(student_2)
    end
  end
end


