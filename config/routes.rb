Rails.application.routes.draw do
  get 'playlist/index'
  get 'playlist/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  post 'welcome/set_current_playlist', to: 'welcome#set_current_playlist'
  get 'welcome/set_current_playlist', to: 'welcome#set_current_playlist'

end
