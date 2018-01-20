#
#   __Note__
#
#   위에서부터 순서대로 매칭 시도함.
#   따라서, 정렬은 빠른 로딩이 요구되거나
#   불필요한 매칭시도가 최소화 되는 순서대로 정렬할 것.
#
Rails.application.routes.draw do
    root 'home#index'

    scope module: :action do
        resources :view_counts
        resources :likes
        resources :bookmarks
        resources :subscribes
    end

    devise_for :users, controllers: {
        sessions: 'users/sessions',
        omniauth_callbacks: 'users/omniauth_callbacks'
    }
    devise_scope :user do
        get 'users/:id(.:format)', :to => 'users/sessions#show', as: 'user'
        get 'users/me', :to => 'users/sessions#my_page', as: 'my_page'
        match "/auth/kakao/callback(.:format)", to: 'users/omniauth_callbacks#kakao', via: [:get, :post]
    end

    resources :posts
    resources :themes

    get 'home/index'
    post 'home/crawler'
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
