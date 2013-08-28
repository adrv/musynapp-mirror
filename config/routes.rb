Musynapp::Application.routes.draw do

  resources :venues, only: [:edit, :edit_media, :add_show]
  
  resources :registrations, only: [:new, :create] do
    collection { post   'login' }
    collection { delete 'logout' }
  end
  
  resources :fans, only: [:edit, :update, :show]

  resources :venues, only: [:edit, :update, :show] do
    member { get 'edit_media' }
    member { get 'add_show' }
  end

  resources :bands, only: [:edit, :update, :show] do
    member { get 'edit_media' }
  end
    

  root 'welcome#index'

end
