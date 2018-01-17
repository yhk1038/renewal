class Theme < ApplicationRecord
    belongs_to :user
    belongs_to :theme_group
    has_many :posts

    def self.populars
        records = self.order(created_at: :desc)
        self.filter(records, 'posts', 5)
    end
end