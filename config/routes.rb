Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'repo_stats#index'
  get 'repo_stats/index'
  
  #webhooks
  get 'payload/stars'
  post 'payload/stars', to: 'payload#stars'
end
