Devise.setup do |config|
  config.secret_key = '6863254af0458e8b514832bae07408609ec3efc9fe41e27bdda0545703f817525971a5630f550e5027ff93f8ec2919c93eaf2fd99762f23b95d054779f96154f'
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 8..72
  config.sign_out_via = :delete
  config.omniauth :google_oauth2, Rails.application.secrets.google_client_id, Rails.application.secrets.google_client_secret,{ }
end
