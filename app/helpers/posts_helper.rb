module PostsHelper

    def active_like? post
        user_signed_in? && post.is_active?('likes', current_user)
    end

    def active_bookmark? post
        user_signed_in? && post.is_active?('bookmarks', current_user)
    end

    def active_subscribe? post
        user_signed_in? && post.user.is_subscribed?(current_user)
    end
end
