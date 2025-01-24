class BaseController < ApplicationController
  before_action :verify_authentication, only: [:create]

  def verify_authentication
    token = extract_token_from_headers
    rpc_response = request_rpc_authentication(token)
    response_data = parse_rpc_response(rpc_response)

    if response_data['status']
      Rails.logger.info 'DEBUG: User authenticated successfully'
    else
      render json: { status: false, message: 'User authentication failed', data: :unauthorized }, status: :unauthorized
    end
  rescue RestClient::ExceptionWithResponse => e
    handle_rpc_error(e)
  rescue StandardError => e
    handle_standard_error(e)
  end

  protected

  # Extracts the token from the Authorization header.
  def extract_token_from_headers
    authorization_header = request.headers['HTTP_AUTHORIZATION']
    if authorization_header.present?
      eval(authorization_header)[:token]
    else
      render json: { status: false, message: 'Authentication token missing' }, status: :unauthorized and return
    end
  end

  # Makes a remote procedure call to authenticate the token.
  def request_rpc_authentication(token)
    RestClient.post(
      ENV.fetch('RPC_API_URL'),
      { Authorization: { token: token } },
      { content_type: :json, accept: :json }
    )
  end

  # Parses the RPC authentication response.
  def parse_rpc_response(response)
    JSON.parse(response)
  rescue JSON::ParserError
    render json: { status: false, message: 'Invalid response from RPC server' }, status: :internal_server_error and return
  end

  def handle_rpc_error(error)
    render json: { status: false, message: "RPC authentication error: #{error.response}" }, status: :internal_server_error
  end
  
  def handle_standard_error(error)
    render json: { status: false, message: "Unexpected error: #{error.message}" }, status: :internal_server_error
  end


end
