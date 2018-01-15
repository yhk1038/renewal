class Theme < ApplicationRecord
    belongs_to :user
    belongs_to :theme_group
    has_many :posts

    def self.populars
        last(4)
    end
end
