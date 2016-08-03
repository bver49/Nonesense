Rails.application.routes.draw do

    root "users#signup"

    resources :posts do
      resources :comments, only: [:create]
    end
    resources :comments, only: [:destroy]

    #Message
    resources :messages, except: [:update,:edit]

    #Admin folder
    resources :folders do
      get 'choose_addpost' => 'folders#choose_addpost'
      get 'choose_removepost' => 'folders#choose_removepost'
    end
    get 'myfolder/:id' => 'folders#myfolder', :as => "myfolder"
    put 'addpost/:id' => 'folders#addpost' ,:as => 'addpost'
    delete 'removepost/:id' => 'folders#removepost' ,:as => 'removepost'

    #User sign up login
    resources :users,except: [:new]
    get 'signup' => 'users#signup',:as => 'signup'
    get "login" => "users#login", :as => "login"
    post "create_login_session" => "users#create_login_session"
    delete "logout" => "users#logout", :as => "logout"
    post 'draw' => 'users#draw'

    #Follow user
    post ':id/follow_user' => 'relationships#follow_user', :as => 'follow_user'
    post ':id/unfollow_user' => 'relationships#unfollow_user',:as => 'unfollow_user'
    get 'following/:id' => 'users#following', :as => 'following'

    #Like post
    post ':id/like_post' => 'likes#likepost', :as => 'likepost'
    post ':id/unlike_post' => 'likes#unlikepost',:as => 'unlikepost'

    #Notify
    post 'clearnotify/:id' => 'messages#clearnotify'
    get 'notice' => 'messages#notice'

    #For admin
    get 'adminuser' => 'users#adminuser'
    get 'adminpost' => 'users#adminpost'
    post ':id/upgradeuser' => 'users#upgradeuser',:as => 'upgradeuser'
    delete "admindestroy/:id" => "users#admindestroy" ,:as => 'admindestroy'

    #draw msg
    resources :drawmsgs,only: [:create]
end
