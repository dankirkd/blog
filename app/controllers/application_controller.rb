class ApplicationController < ActionController::Base
  protect_from_forgery
 
  private

  def authenticate
    edit_access = YAML::load(File.open("#{Rails.root}/config/app.yml"))["edit_access"]
    logger.info("********** #{edit_access}") 
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == edit_access["user_name"] && password == edit_access["password"]
    end
  end

end
