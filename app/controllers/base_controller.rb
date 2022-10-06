class BaseController < ApplicationController
    before_action :verify_authentication


    def verify_authentication
	  	if request.headers['HTTP_AUTHORIZATION']

	    	header_params = eval(request.headers['HTTP_AUTHORIZATION'])
	   		decoded_response = decrypt(header_params[:token], 'hmac_secret_key', 'HS256')
		    if (@user = User.find_by_jti(decoded_response[:jti]))
		      role_user = @user.has_role? :student
		      role_admin = @user.has_role? :admin
		      @student = Student.where(email: @user.email).first

		      if role_user && !role_admin
		        render json: { status: true, role_student: role_user, id: @student.uuid, message: 'User Authenticated ' }
		      end

		      if role_admin
		        render json: { status: true, role_admin: role_admin, message: 'User Authenticated ' }
		      end

		    else
		      render json: { data: :unauthorized, status: :created, message: 'user failed logged in' }
		    end
		else 
		   render json: { data: :unauthorized, status: :created, message: 'user failed logged in' }  

	  	end
    end


end
