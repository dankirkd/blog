class ApplicationController < ActionController::Base
  protect_from_forgery
 
  private

  def load_properties(properties_filename)
    properties = {}
    File.open(properties_filename, 'r') do |properties_file|
      properties_file.read.each_line do |line|
        line.strip!
        if (line[0] != ?# and line[0] != ?=)
          i = line.index('=')
          if (i)
            properties[line[0..i - 1].strip] = line[i + 1..-1].strip
          else
            properties[line] = ''
          end
        end
      end      
    end
    properties
  end
 
  def authenticate
    rails_root = ::Rails.root.to_s
    properties = load_properties("#{rails_root}/config/app.properties")
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == properties["user_name"] && password == properties["password"]
    end
  end

end
