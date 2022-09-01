Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root :to =>"homes#top"
  get "home/about"=>"homes#about"

  resources :books,only: [:index, :show, :edit, :create, :destroy, :update] do
   resources :book_comments,only: [:create, :destroy]
   resource :favorites,only: [:create, :destroy]
  end

  resources :users,only: [:index, :show, :edit, :update] do
    resources :relationships, only: [:create, :destroy] do
      member do
        get 'following' => 'relationships#followings', as:'followings'#フォローされた方の情報を取得
        get 'followers' => 'relationships#followers', as:'followers'#フォローした方の情報を取得
      end
    end
  end
   # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end