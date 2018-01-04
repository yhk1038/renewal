class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    $appname = Rails.application.class.parent_name

end
