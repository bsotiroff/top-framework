Rails.application.routes.draw do
  get 'repo_stats/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'repo_stats#index'
  post 'repo_stats/click', to: 'repo_stats#click'
  post 'repo_stats/fetch_api_data', to: 'repo_stats#fetch_api_data'
end
