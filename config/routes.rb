Rails.application.routes.draw do
	namespace :api, defaults: {format: :json} do
		resources :login, only: [:create]
		resources :users do
			post 'forgot_password', on: :collection
			post 'reset', on: :collection
		end
		resources :skills
		get 'reports/tags', controller: :reports, action: :tags
		resources :skills_users do
			collection do
				put 'update', action: :update_skills
				delete 'delete/:user_id/:skill_id', action: :delete_skills
			end
		end
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
