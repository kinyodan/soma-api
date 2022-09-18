module JwtUtils
  require 'jwt'
  def self.encrypt(payload, salt, algo = 'HS256')
    JWT.encode payload, salt, algo
  end
  def self.decrypt(token, salt, algo = 'HS256')
    decrypted_token = JWT.decode token, salt, algo
    decrypted_token.first.deep_symbolize_keys rescue {}
  end
end