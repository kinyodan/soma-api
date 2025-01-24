require 'rails_helper'

RSpec.describe Api::V1::InstitutionsController, type: :request do
  let(:institution) { institutions(:one) }

  describe "GET /institutions" do
    it "returns a successful response" do
      get institutions_path, as: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /institutions" do
    it "creates a new institution" do
      expect {
        post institutions_path, params: { institution: { country_code: institution.country_code, name: institution.name, website: institution.website } }, as: :json
      }.to change(Institution, :count).by(1)
      
      expect(response).to have_http_status(:created)
    end
  end

  describe "GET /institutions/:id" do
    it "shows the institution" do
      get institution_path(institution), as: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /institutions/:id" do
    it "updates the institution" do
      patch institution_path(institution), params: { institution: { country_code: institution.country_code, name: institution.name, website: institution.website } }, as: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE /institutions/:id" do
    it "deletes the institution" do
      expect {
        delete institution_path(institution), as: :json
      }.to change(Institution, :count).by(-1)
      
      expect(response).to have_http_status(:no_content)
    end
  end
end
