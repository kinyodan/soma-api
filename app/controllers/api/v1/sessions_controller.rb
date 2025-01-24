require 'jwt'

class Api::V1::SessionsController < ApplicationController
  skip_before_action :verify_authenticated

  def create
    header_params = JSON.parse(request.headers['HTTP_AUTHORIZATION'])
    user = User.find_by_email(header_params['email'])
  
    if user&.valid_password?(header_params['password'])
      encoded_response = JwtService::Decryption.new.encrypt(user.as_json(only: [:jti, :email]))
      @student = Student.find_by(email: user.email)
  
      role = user.has_role?(:admin) ? 'admin' : 'student'
      response = {
        user: encoded_response,
        role: role,
        profile: user.email,
        id: @student&.uuid,
        status: true,
        message: 'User logged in'
      }
  
      render json: response
    else
      render json: { status: false, message: 'Invalid email or password' }, status: :unauthorized
    end
  end
  

  def destroy
    render json: { status: true, message: 'Nothing to do here' }

  end

end