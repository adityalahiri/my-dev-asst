Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "pages#home"
  get '/messages', to: 'messages#index'
  get '/messages/new', to:'messages#new'
  post 'messages', to:'messages#create'
  resources :messages do
    get 'invoke_llm', on: :collection
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
