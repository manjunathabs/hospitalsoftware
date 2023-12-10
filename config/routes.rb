#Rails.application.routes.draw do
#  get 'patients/new'
#  get 'patients/create'
#  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
#end



# config/routes.rb
Rails.application.routes.draw do
#  root 'home#index'

  root 'sessions#new'
  get 'home', to: 'home#new'
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'signup', to: 'users#new', as: 'signup'
  post 'signup', to: 'users#create'
  get 'patients/new', to: 'patients#new', as: 'new_patient'
 
  post 'patients', to: 'patients#create'
  resources :users, only: [:new, :create]
  resources :patients do
   get :index, on: :collection, format: [:html, :pdf, :xlsx]
   resources :appointments, only: [:new, :create]
   collection do
    get 'filter_by_date'
  end
 #      resources :bills, only: [:index]
    #resources :billings,only: [:index]

  end
  resources :appointments, only: [:index]
      resources :billings,only: [:index,:create]
      get 'billings/search',to: 'billings#search'
      post 'make_payment', to: 'billings#make_payment'
      get :show_receipt, to: 'billings#show_receipt'
 
#    resources :billings

end

