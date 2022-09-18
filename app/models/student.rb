require 'securerandom'
require 'MailchimpMarketing'

class Student < ApplicationRecord
  before_create :create_user
  before_create :create_uuid
  validates_uniqueness_of :email

  def create_uuid
    ustring = SecureRandom.uuid
    uuid = ustring.split(/-/)
    self.uuid = uuid[0]
  end

  def create_user
    random_string = "password01"
    @user = User.new(email: self.email , password: random_string, password_confirmation: random_string)
    @user.save
    send_email(@user)
  end

  def send_email(user)
    p user
    begin
      client = MailchimpMarketing::Client.new()
      client.set_config({
                          :api_key => ENV.fetch('MAILCHIMP_API_KEY'),
                          :server =>  ENV.fetch('MAILCHIMP_SERVER_PREFIX'),
                        })
      result = client.ping.get()
      p result
    rescue MailchimpMarketing::ApiError => e
      puts "Error: #{e}"
    end
  end

end
