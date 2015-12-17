Rails.application.routes.draw do
  namespace :admin do
    DashboardManifest::DASHBOARDS.each do |dashboard_resource|
      resources dashboard_resource
    end

    root controller: DashboardManifest::ROOT_DASHBOARD, action: :index
  end
  get 'tags/:tag', to: 'books#index', as: :tag
  resources :books do
    resources :book_files, only: [:create, :update, :destroy]
    post 'new/isbn', to: 'books#get_book', as: 'get_book', on: :collection
    post 'comment', on: :member
    post 'get_book_from/:site', to: 'books#get_book_from', as: 'get_book_from', on: :member
  end
  resources :categories
  resources :authors, only: [:index, :show]
  get 'results', to: 'results#index', as: 'results'
  root to: 'books#index'
  # root to: 'main#index'
  get 'users', to: 'users#index'
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
