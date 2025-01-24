class ApplicationController < ActionController::API
  include JwtService

#   Added the single sign in api authenticationon so auth is done
#   in base_controller since all other classes inherit from base_controller,
#   by RPC call to external microservice single sign-in api app.
#   local authentication commented out for now .
#   before_action :verify_authenticated

  def verify_authenticated
    token = extract_token_from_headers
    decoded_response = JwtService::Encryption.new.decrypt(token)

    unless user_authenticated?(decoded_response)
      render json: { status: false, message: 'User authentication failed' }, status: :unauthorized
    end
  rescue JWT::DecodeError => e
    handle_jwt_decode_error(e)
  rescue StandardError => e
    handle_standard_error(e)
  end

  private

  def extract_token_from_headers
    authorization_header = request.headers['HTTP_AUTHORIZATION']
    if authorization_header.present?
      authorization_header.split.last
    else
      render json: { status: false, message: 'Authorization header missing' }, status: :unauthorized and return
    end
  end

  def user_authenticated?(decoded_response)
    @user = User.find_by_jti(decoded_response[:jti])
    if @user
      true
    else
      false
    end
  end

  def handle_jwt_decode_error(error)
    render json: { status: false, message: "Invalid token: #{error.message}" }, status: :unauthorized
  end
  
  def handle_standard_error(error)
    render json: { status: false, message: "Unexpected error: #{error.message}" }, status: :internal_server_error
  end

end
