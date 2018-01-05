class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable,
           :omniauthable, omniauth_providers: [:kakao, :facebook]

    def self.find_by_oauth(auth)
        find_or_create_by(uid: auth.uid, provider: auth.provider)
    end

    def self.find_for_oauth(auth, signed_in_resource = nil)
        # user가 nil이 아니라면 받는다

        user = signed_in_resource ? signed_in_resource : User.find_by_oauth(auth)

        # 신규 user라면 새로 만든다.

        if user.id.nil?

            # 이미 있는 이메일인지 확인한다.

            user = User.where(email: auth.info.email).take

            unless user
                # 없다면 새로운 데이터를 생성한다.

                user = User.new
                user.email          = auth.info.email               if auth.provider != "kakao"     # 카카오는 email을 제공하지 않음
                user.password       = Devise.friendly_token[0,20]
                user.profile_img    = auth.info.image
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
