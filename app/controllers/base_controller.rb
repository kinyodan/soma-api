class BaseController < ApplicationController
    before_action :verify_authentication , only: %i[ create ]


    def verify_authentication
	  	if request.headers['HTTP_AUTHORIZATION']

	    	header_params = eval(request.headers['HTTP_AUTHORIZATION'])
	   		decoded_response = decrypt(header_params[:token], 'hmac_secret_key', 'HS256')
		    rpc_response = request_rpc_authentication(header_params[:token])
		    data = JSON.parse(rpc_response)
		   
		    if data['status']
		      # render json: data
		    else
		      render json: { data: :unauthorized, status: false, message: 'user failed logged in' }
		    end

		else 
           header_params = eval(request.headers['HTTP_AUTHORIZATION'])
		   render json: { data: :unauthorized, status: :false, message: 'user failed Authentication no token' }  

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
