Apipie.configure do |config|
  config.app_name                = "TV API"
  config.app_info                = "Streaming Content Management System"
  config.api_base_url            = "/api/v1"
  config.doc_base_url            = "/apipie"
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/**/*.rb"
  config.validate                = false
  config.reload_controllers      = Rails.env.development?
  config.default_version         = "v1"
end
