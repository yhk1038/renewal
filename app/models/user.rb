class User < ApplicationRecord
    include RestClient
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable,
           :omniauthable, :omniauth_providers => [:kakao, :facebook]

    has_many :posts
    has_many :themes

    has_many :likes
    has_many :bookmarks
    has_many :view_counts

    def is_valid?
        self.name &&
            self.email &&
            self.provider &&
            self.uid &&
            self.profile_img
    end

    def email_address
        self.email.gsub(".auth.#{self.provider}",'')
    end

    #
    # OAuth Logic are below
    #

    def self.find_by_oauth(auth)
        find_or_create_by(uid: auth.uid, provider: auth.provider)
    end

    def self.get_kakao_user(auth)
        rest =  RestClient.post('https://kauth.kakao.com/oauth/token', {
                    content_type: :json,
                    accept: :json
                },
                params: {
                    grant_type: 'refresh_token',
                    client_id: ENV['KAKAO_REST_API_KEY'],
                    refresh_token: auth.credentials.refresh_token
                })
        tokens = JSON.parse(rest.body, symbolize_names: true)

        info =  RestClient.get('https://kapi.kakao.com/v1/user/me', headers={
            'Authorization': "Bearer #{tokens[:access_token]}"
        })
        JSON.parse(info.body, symbolize_names: true)[:kaccount_email]+'.auth.kakao'
    end

    def self.find_for_oauth(auth, signed_in_resource = nil)
        # user가 nil이 아니라면 받는다

        myprint( auth.to_hash)

        user = signed_in_resource ? signed_in_resource : User.find_by_oauth(auth)

        # 신규 user라면 새로 만든다.

        if user.id.nil?

            # 이미 있는 이메일인지 확인한다.

            email = auth.provider == 'kakao' ? User.get_kakao_user(auth) : "#{auth.info.email}.auth.#{auth.provider}"
            user = User.where(email: email).take

            unless user
                # 없다면 새로운 데이터를 생성한다.
                user = User.new
                user.email          = email if email
                user.password       = Devise.friendly_token[0,20]
                user.profile_img    = auth.info.image
                user.name           = auth.info.name
                user.provider       = auth.provider
                user.uid            = auth.uid
                # user.remote_profile_img_url = auth.info.image.gsub('http://','https://')
                user.save!
            end
        end
        user

    end

    # email이 없어도 가입이 되도록 설정

    def email_required?
        false
    end
end


def myprint(res)
    puts "\n\n\n\n\n\n"
    ap res
    puts "\n\n\n\n\n\n"
end