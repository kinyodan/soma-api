module ProjectUtils
  require 'utils/jwt_utils'
  def self.encrypt(payload)
    JwtUtils.encrypt(payload, "hmac_secret_key", "HS256")
  end
  def self.decrypt(token)
    JwtUtils.decrypt(token, "hmac_secret_key", "HS256")
  end
end