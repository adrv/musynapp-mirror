Musynapp::Application.routes.draw do

  resources :venues, only: [:edit, :edit_media, :add_show]
  
  resources :registrations, only: [:new, :create] do
    collection { post   'login' }
    collection { delete 'logout' }
  end
  
  resources :images, only: :destroy
  resources :videos, only: :destroy
  resources :songs, only: :destroy

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
