class UserMailer < ApplicationMailer
  def welcome_email(user)
    mail(to: user, subject: "Welcome! to Wankimani Solutions").tap do |message|
      message.mailgun_options = {
        "tag" => ["abtest-option-a", "beta-user"],
        "tracking-opens" => true,
        "tracking-clicks" => "htmlonly"
      }
    end
  end
end
