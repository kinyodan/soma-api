require 'rails_helper'

RSpec.describe BaseController, type: :controller do
  # Mocked test data
  let(:valid_token) { 'valid_token_123' }
  let(:invalid_token) { 'invalid_token_123' }
  let(:rpc_response_success) { { 'status' => true }.to_json }
  let(:rpc_response_failure) { { 'status' => false, 'message' => 'Authentication failed' }.to_json }
  let(:rpc_error) { RestClient::ExceptionWithResponse.new(double('response')) }

  before do
    # Mocking environment variables for the tests
    allow(ENV).to receive(:fetch).with('RPC_API_URL').and_return('http://fake-rpc-url.com')

    # Mocking the external methods
    allow(controller).to receive(:extract_token_from_headers).and_return(valid_token)
  end

  describe 'POST #verify_authentication' do
    context 'when the token is valid' do
      it 'authenticates the user successfully' do
        # Mocking the response of the request_rpc_authentication method
        allow(controller).to receive(:request_rpc_authentication).and_return(rpc_response_success)

        post :create # assuming this is the action where the before_action is triggered

        # Ensure that the authentication was successful and no errors occurred
        expect(response).to have_http_status(:success)
        expect(response.body).to include('User authenticated successfully')
      end
    end

    context 'when the token is invalid' do
      it 'returns unauthorized status with a failure message' do
        # Mocking the response of the request_rpc_authentication method to simulate failure
        allow(controller).to receive(:request_rpc_authentication).and_return(rpc_response_failure)

        post :create

        # Ensure that unauthorized status and the correct error message are returned
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to include('User authentication failed')
      end
    end

    context 'when the token is missing' do
      before do
        allow(controller).to receive(:extract_token_from_headers).and_return(nil)
      end

      it 'returns unauthorized status with a missing token message' do
        post :create

        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to include('Authentication token missing')
      end
    end

    context 'when there is an RPC error' do
      it 'returns an internal server error with a RPC error message' do
        allow(controller).to receive(:request_rpc_authentication).and_raise(rpc_error)

        post :create

        expect(response).to have_http_status(:internal_server_error)
        expect(response.body).to include('RPC authentication error')
      end
    end

    context 'when there is a general error' do
      it 'returns an internal server error with the error message' do
        allow(controller).to receive(:request_rpc_authentication).and_raise(StandardError.new('Test error'))

        post :create

        expect(response).to have_http_status(:internal_server_error)
        expect(response.body).to include('Unexpected error: Test error')
      end
    end
  end
end

