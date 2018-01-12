class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    $appname = Rails.application.class.parent_name

    def is_login?
        redirect_back(fallback_location: root_path) unless user_signed_in? || current_user.is_valid?
        true
    end
end
