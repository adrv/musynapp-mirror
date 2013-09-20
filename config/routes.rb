Musynapp::Application.routes.draw do

  resources :requests, only: :index do
    member { post :accept }
    member { post :reject }
    collection { post :manage_selection }
  end

  resources :conversations do 
    member { post :send_message }
  end

  resources :shows do
    member { post 'request_address' }
  end
  
  resources :venues, only: [:edit, :edit_media, :add_show, :index]

  resources :registrations, only: [:new, :create] do
    collection { post   'login' }
    collection { delete 'logout' }
    member     { post   'skip' }
  end

  resources :uploads, only: [:create, :destroy] do 
    member { get 'download' }
  end

  resources :songs do
    member { post 'make_primary' }
  end


  resources :fans, only: [:edit, :update, :show]

  resources :venues, only: [:edit, :update, :show] do
    member { get 'edit_media' }
    member { get 'add_show' }
    collection { get 'find' }
  end

  resources :bands, only: [:edit, :update, :show] do
    member { get 'edit_media' }
    collection { get 'find' }
    resources :images, only: :destroy, shallow: true
  end
  

  root 'welcome#index'

end
