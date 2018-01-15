class Post < ApplicationRecord
    belongs_to :user
    belongs_to :theme, optional: true

    has_many :likes
    has_many :bookmarks
    has_many :view_counts


    def is_active?(res, current_user)
        eval("self.#{res}.find_by(user: current_user)")
    end
end
