require 'MailchimpMarketing'

begin
  client = MailchimpMarketing::Client.new()
  client.set_config({
                      :api_key => ENV.fetch('MAILCHIMP_API_KEY'),
                      :server => ENV.fetch('MAILCHIMP_SERVER_PREFIX'),
                    })
  result = client.ping.get()
  p result
rescue MailchimpMarketing::ApiError => e
  puts "Error: #{e}"
end