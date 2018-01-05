Rails.application.routes.draw do
    root 'home#index'
    get 'home/index'

    devise_for :users, controllers: {
        sessions: 'users/sessions',
        omniauth_callbacks: 'users/omniauth_callbacks'
    }

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
