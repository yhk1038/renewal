class Post < ApplicationRecord
    belongs_to :user
    belongs_to :theme, optional: true

    has_many :likes
    has_many :bookmarks
    has_many :view_counts
    has_many :subscribes


    def is_active?(res, current_user)
        eval("self.#{res}.find_by(user: current_user)")
    end

    def author
        self.user
    end

    def view_count
        self.view_counts.count
    end

    def self.sort_of(method)
        case method
        when 'new'
            order(created_at: :desc)
        end
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
