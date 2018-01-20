require 'open-uri'

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
        @carousels = [
            {
                id: 1,
                about:      ['', '다가오는 명강연'],
                background_img: 'https://i.ytimg.com/vi/Ki6VYGnUBWU/maxresdefault.jpg',
                href: 'https://www.youtube.com/watch?v=Ki6VYGnUBWU',
                title: '[세바시 청소년] 우린 열대어입니다',
                subtitle:   ['', '김상윤 신송중학교 2년'],
                produce:    ['제작 : ', '세바시스쿨, 세바시', ' <br>'],
                when:       ['시간 : ', '2018. 2. 3.'],
                where:      [' , 장소 : ', '서울시 세바시 강연장']
            },
            {
                id: 2,
                about:      ['', '다가오는 명강연'],
                background_img: 'http://mblogthumb1.phinf.naver.net/MjAxNzA0MjZfMTQ5/MDAxNDkzMTY4MzUzMTU3.lEMZlKTvgwydkKj3sy1XuNgSmOJla2YEsKUEFAfiJYUg.Wt3_Ss87iX_1azD2_O2uOgoJh1mrnv6-cQ5sAIci6bkg.PNG.cjenm0901/%EC%96%B4%EC%A9%8C%EB%8B%A4%EC%96%B4%EB%A5%B8_1.png?type=w2',
                href: 'https://www.youtube.com/watch?v=Ki6VYGnUBWU',
                title: '[세바시 청소년] 우린 열대어입니다',
                subtitle:   ['', '김상윤 신송중학교 2년'],
                produce:    ['제작 : ', '세바시스쿨, 세바시', ' <br>'],
                when:       ['시간 : ', '2018. 2. 3.'],
                where:      [' , 장소 : ', '서울시 세바시 강연장']
            },
            {
                id: 3,
                about:      ['', '다가오는 명강연'],
                background_img: 'http://via.placeholder.com/1450x570',
                href: 'https://www.youtube.com/watch?v=Ki6VYGnUBWU',
                title: '[세바시 청소년] 우린 열대어입니다',
                subtitle:   ['', '김상윤 신송중학교 2년'],
                produce:    ['제작 : ', '세바시스쿨, 세바시', ' <br>'],
                when:       ['시간 : ', '2018. 2. 3.'],
                where:      [' , 장소 : ', '서울시 세바시 강연장']
            }
        ]
    end

    def section_data(args={})
        title   = args[:title]  || nil
        tracks  = args[:tracks] || nil
        method  = args[:method] || 'new'
        label   = args[:label]  || true

        return nil if tracks.nil?
        {title: title, tracks: tracks, method: method, label: label}
    end


    def crawler
        target = params[:target]
        provider    = target[:provider]
        target_url  = target[:url]

        case provider
        when 'youtube'
            # get html body
            doc = Nokogiri::HTML(RestClient.get(target_url).body)
            metas = doc.css('head meta')

            # parse meta tag (:title, :image, :video_url)
            # parse info (:runtime)
            white_list  = %w(title image description video:secure_url video:tag).map{|e| 'og:'+e}

            # title:        og:title
            # image:        og:image
            # description:  og:description
            # video_url:    og:video:secure_url
            # tags:         og:video:tag (many of)
            # runtime:      og:video:          # !! can't parse !!
            hash = {}
            white_list.each do |property|
                eval("hash['#{property.gsub('og:','').gsub(':','_')}'.to_sym] = metas.css('meta[property=\"#{property}\"]')[0]['content']")
            end

            render json: {provider: provider, detail: hash, status: 200 , message: 'ok'}

        when 'facebook'
            # get html body
            # parse meta tag (:title, :image)
            # parse info (:runtime, :video_url)

        end
    end
end
