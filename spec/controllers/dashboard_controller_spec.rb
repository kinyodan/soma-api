require 'rails_helper'

RSpec.describe Api::V1::DashboardController, type: :request do
  describe "GET /dashboard" do
    it "returns a successful response" do
      get dashboard_index_path
      expect(response).to have_http_status(:success)
    end
  end
end
