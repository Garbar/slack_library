CarrierWave.configure do |config|
  config.dropbox_app_key = ENV["dropbox_app_key"]
  config.dropbox_app_secret = ENV["dropbox_app_secret"]
  config.dropbox_access_token = ENV["dropbox_access_token"]
  config.dropbox_access_token_secret = ENV["dropbox_access_token_secret"]
  config.dropbox_user_id = ENV["dropbox_user_id"]
  config.dropbox_access_type = "app_folder"

  # config.box_client_id = ENV["box_app_key"]
  # config.box_client_secret = ENV["box_app_secret"]
  # config.box_email = ENV["box_email"]
  # config.box_password = ENV["box_password"]
  # config.box_access_type = "box"
  # config.cache_dir = "#{Rails.root}/tmp/uploads"
  # config.enable_processing = true
end
