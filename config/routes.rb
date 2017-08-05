Rails.application.routes.draw do
	namespace :api, defaults: {format: :json} do 
		resources :login, only: [:create]
		resources :users
		resources :skills
		resources :skills_users do 
			collection do 
				put 'update', action: :update_skills
				delete 'delete/:user_id/:skill_id', action: :delete_skills
			end
		end
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
