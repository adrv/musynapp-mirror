Musynapp::Application.routes.draw do

  resources :shows
  resources :venues, only: [:edit, :edit_media, :add_show, :index]

  get 'find_venue', to: 'venues#find'
  get 'find_band', to: 'bands#find'

  resources :registrations, only: [:new, :create] do
    collection { post   'login' }
    collection { delete 'logout' }
  end

  resources :uploads, only: [:create, :destroy] do 
    member { get 'download' }
  end


  resources :fans, only: [:edit, :update, :show]

  resources :venues, only: [:edit, :update, :show] do
    member { get 'edit_media' }
    member { get 'add_show' }
  end

  resources :bands, only: [:edit, :update, :show] do
    member { get 'edit_media' }
    resources :images, only: :destroy, shallow: true
  end
  

  root 'welcome#index'

end
