unless Rails.env.development?
  ActionMailer::Base.delivery_method = :smtp

  ActionMailer::Base.raise_delivery_errors = true
  ActionMailer::Base.perform_deliveries = !Rails.env.test?

  ActionMailer::Base.smtp_settings = {
      :address              => 'smtp.gmail.com',
      :port                 => 587,
      :domain               => 'gmail.com',
      :user_name            => ENV['GMAIL_SMTP_USER'],
      :password             => ENV['GMAIL_SMTP_PASSWORD'],
      :authentication       => 'login',
      :enable_starttls_auto => true
  }
end
