Rails.application.routes.draw do
	namespace :api do 
		resources :login, only: [:create]
		resources :users
		resources :skills
		resources :skills_users
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
