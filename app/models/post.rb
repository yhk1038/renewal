class Post < ApplicationRecord
    belongs_to :user
    belongs_to :theme, optional: true

    has_many :likes
    has_many :bookmarks
    has_many :view_counts


    def is_active?(res, current_user)
        eval("self.#{res}.find_by(user: current_user)")
    end

    def self.to_embed(args={})
        provider = args[:provider] || nil
        url      = args[:url] || nil

        if provider
            case provider
            when 'facebook'
                url = "https://www.facebook.com/plugins/video.php?href=#{url.gsub(/:/, '%3A').gsub(/\//, '%2F')}&show_text=0&width=560"
            end
        end
        return url
    end
end
