Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get 'signup', to: 'users#new'
  get 'users', to: 'users#new'
  resources :users, except: [:index] do
    post 'setPerformance', to: 'users#setPerformanceMode'
  end
  resources :playlists do
    post 'changeSong', to: 'application#changeSong'
    post 'updateImportNumber', to: 'playlists#updateImportNumber'

  end
  resources :songs
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'tbd', to: 'playground#index'
  post 'nextSong', to: 'application#nextSong'
end
