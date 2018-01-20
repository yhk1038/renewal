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

    def to_carousel user
        {
            id:                 self.id?,
            about:              ['', self.about?],
            background_img:     self.background_img?,
            href:               self.href?,
            title:              self.title?,
            subtitle:           ['', self.subtitle?],
            produce:            ['제작 : ', self.producers?(user), ' <br>'],
            when:               ['시간 : ', self.when?],
            where:              [' , 장소 : ', '서울시 세바시 강연장']
        }
    end

    def id?
        self.id ? self.id : 0
    end

    def about?
        self&.theme_group&.title || 'about of theme'
    end

    def href?
        self.id ? 'javascript:;' : 'javascript:;'
    end

    def background_img?
        if self.background_img
            self.background_img
        else
            self.id ? self&.posts&.last&.thumbnail_img : '/template/img/headers/1.png'
        end
    end

    def title?
        self.id ? self.title : 'title of theme'
    end

    def subtitle?
        self.id ? '김상윤 신송중학교 2년' : '김상윤 신송중학교 2년'
    end

    def producers? user
        self.id ? "#{self.user.name} 외 1명" : "#{user.name}"
    end

    def when?
        self.id ? self.updated_at.strftime('%Y. %m. %d.') : Time.zone.now.strftime('%Y. %m. %d.')
    end
end