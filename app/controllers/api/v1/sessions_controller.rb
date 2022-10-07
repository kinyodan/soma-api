require 'jwt'

class Api::V1::SessionsController < ApplicationController
  # skip_before_action :verify_authenticated
  #
  # def initMail
  #   p "initializing mailer"
  #   current_user = "kinyodaniel@gmail.com"
  #   mailer = UserMailer.welcome_email(current_user)
  #   mailer_response = mailer.deliver_now
  #   mailgun_message_id = mailer_response.message_id
  #   p mailgun_message_id
  # end

  def create
    header_params = eval(request.headers['HTTP_AUTHORIZATION'])
    user = User.where(email: header_params[:email]).first

    if (@user = User.find_by_email(header_params[:email])) && @user.valid_password?(header_params[:password])
      encoded_response = encrypt(user.as_json(only: [:jti, :email]), 'hmac_secret_key', 'HS256')
      role_user = @user.has_role? :student
      role_admin = @user.has_role? :admin
      @student = Student.where(email: @user.email).first
      student_uuid = nil
      student_uuid = @student.uuid if @student

      if role_user && !role_admin
        render json: { user: encoded_response, role_student: role_user , profile: @user.email,id: student_uuid , status: true, message: 'user logged in' }
      end

      if role_admin
        render json: { user: encoded_response, role_admin: role_admin , profile: @user.email, status: true, message: 'user logged in' }
      end

    else
      render json: { data: :unauthorized, status: false, message: 'user failed logged in' }
    end
  end

  def destroy

  end

  def verify_authentication

    header_params = eval(request.headers['HTTP_AUTHORIZATION'])
    decoded_response = decrypt(header_params[:token], 'hmac_secret_key', 'HS256')    
    rpc_response = request_rpc_authentication(header_params[:token])
    data = JSON.parse(rpc_response)
   
    if data['status']
      render json: data
    else
      render json: { data: :unauthorized, status: false, message: 'user failed logged in' }
    end

  end

  protected

  def request_rpc_authentication(token)
    response = RestClient.post ENV.fetch('RPC_API_URL'), {:Authorization => {:token=>token}}
  end 

  def encrypt(payload, salt, algo = 'HS256')
    JWT.encode payload, salt, algo
  end

  def decrypt(token, salt, algo = 'HS256')
    decrypted_token = JWT.decode token, salt, algo
    decrypted_token.first.deep_symbolize_keys rescue {}
  end

end