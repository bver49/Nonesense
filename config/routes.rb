Rails.application.routes.draw do

  get 'portfolios/index'

  get 'portfolios/show'

  get 'portfolios/new'

  get 'portfolios/create'

  get 'portfolios/edit'

  get 'portfolios/update'

  get 'portfolios/destroy'

    root "posts#index"

    resources :users,except: [:new]
    resources :messages, except: [:new,:update,:edit]
    resources :posts do
      resources :comments, only: [:create]
    end
    resources :comments, only: [:destroy]
    resources :portfolios do
      get 'choose_addpost' => 'portfolios#choose_addpost'
      get 'choose_removepost' => 'portfolios#choose_removepost'
    end
    put 'addpost/:id' => 'portfolios#addpost' ,:as => 'addpost'
    delete 'removepost/:id' => 'portfolios#removepost' ,:as => 'removepost'


    get 'signup' => 'users#signup',:as => 'signup'
    get "login" => "users#login", :as => "login"
    post "create_login_session" => "users#create_login_session"
    delete "logout" => "users#logout", :as => "logout"

    post ':id/follow_user', to: 'relationships#follow_user', :as => 'follow_user'
    post ':id/unfollow_user', to: 'relationships#unfollow_user',:as => 'unfollow_user'
    post ':id/like_post', to: 'likes#likepost', :as => 'likepost'
    post ':id/unlike_post', to: 'likes#unlikepost',:as => 'unlikepost'

    get 'following' => 'users#following'
    get 'explore' => 'users#explore'

    get 'notice' => 'messages#notice'

    get 'auth' => 'users#auth'
    get 'adminuser' => 'users#adminuser'
    get 'adminpost' => 'users#adminpost'
    post ':id/sendauthmail' => 'users#sendauthmail',:as => 'sendauthmail'
    delete "admindestroy/:id" => "users#admindestroy" ,:as => 'admindestroy'
end
