module JwtService
    class Encryption
        def initialize
            salt ='hmac_secret_key'
            algorithm ='HS256'
        end 

        def encrypt(payload, salt = salt , algo = algorithm)
            JWT.encode payload, salt, algo
        end
    end 

    class Decryption
        def decrypt(token, salt = salt , algo = algorithm)
            decrypted_token = JWT.decode token, salt, algo
            decrypted_token.first.deep_symbolize_keys rescue {}
        end
    end 
    
end