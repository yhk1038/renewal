Rails.application.routes.draw do
    root 'home#index'
    get 'home/index'

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

    scope module: :action do
        resources :view_counts
        resources :bookmarks
        resources :likes
    end

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
