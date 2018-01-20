class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    $appname = Rails.application.class.parent_name

    def is_login?
        redirect_back(fallback_location: root_path) unless user_signed_in? || current_user.is_valid?
        true
    end

    def valid_user res
        unless user_signed_in? && current_user.id == res.user.id
            respond_to do |format|
                format.html {return redirect_back fallback_location: root_path }
                format.json {return render json: res, status: :unprocessable_entity}
            end
        end
    end

    def set_layout_variables
        # default variables setting
        @delivery_display           = true
        @navbar_transparent         = true
        @layout_carousel_display    = true
    end

    def set_layout(arr)
        @delivery_display,
        @navbar_transparent,
        @layout_carousel_display    = arr
    end
end
