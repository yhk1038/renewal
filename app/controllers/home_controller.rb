class HomeController < ApplicationController
    before_action :set_layout_variables

    def index
        # Hot Theme:        Themes * 3
        # Hot Channel:      Themes * 5
        # Theme Recommend:  Themes * 10

        my_channels =   section_data({
                            title: '내가 구독한 채널의 새 소식',
                            tracks: user_signed_in? ? current_user.followings : nil
                        })
        hot_themes =    section_data({
                            title: "#{Time.zone.now.month}월 #{Time.zone.now.week_of_month}주차 BEST 테마",
                            tracks: Theme.populars
                        })
        hot_channels =  section_data({
                            title: "#{Time.zone.now.month}월 #{Time.zone.now.week_of_month}주차 BEST 채널",
                            tracks: [User.first]
                        })
        recommend_themes =  section_data({
                            title: '당신을 위한 추천 컨텐츠',
                            tracks: nil,
                            label: false
                        })
        @sections = [my_channels, hot_themes, hot_channels, recommend_themes].compact
    end

    def section_data(args={})
        title   = args[:title]  || nil
        tracks  = args[:tracks] || nil
        method  = args[:method] || 'new'
        label   = args[:label]  || true

        return nil if tracks.nil?
        {title: title, tracks: tracks, method: method, label: label}
    end
end
