class Theme < ApplicationRecord
    belongs_to :user
    belongs_to :theme_group
    has_many :posts

    def self.populars
        records = self.order(created_at: :desc)
        self.filter(records, 'posts', 5)
    end

    def prev
        themes  = self.theme_group.themes.reverse
        index   = themes.index self

        index += 1
        return nil if index >= themes.count

        themes[index]
    end

    def next
        themes  = self.theme_group.themes.reverse
        index   = themes.index self

        index -= 1
        return nil if index < 0

        themes[index]
    end
end