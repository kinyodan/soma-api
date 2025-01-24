require 'rails_helper'

RSpec.describe Institution, type: :model do
  let(:institution) { create(:institution) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(institution).to be_valid
    end

    it "is not valid without a country_code" do
      institution.country_code = nil
      expect(institution).to_not be_valid
    end

    it "is not valid without a name" do
      institution.name = nil
      expect(institution).to_not be_valid
    end

    it "is not valid without a website" do
      institution.website = nil
      expect(institution).to_not be_valid
    end
  end

  describe "associations" do
    it "has many students" do
      expect(institution).to respond_to(:students)
    end
  end

  describe "scopes" do
    let!(:institution_1) { create(:institution, name: 'Institution One') }
    let!(:institution_2) { create(:institution, name: 'Institution Two') }

    it "returns institutions ordered by name" do
      expect(Institution.order(:name)).to eq([institution_1, institution_2])
    end
  end

  describe "methods" do
    describe "#institution_info" do
      it "returns the institution's name and website" do
        expect(institution.institution_info).to eq("#{institution.name} - #{institution.website}")
      end
    end
  end
end
