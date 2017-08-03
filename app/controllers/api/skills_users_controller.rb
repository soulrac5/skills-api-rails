class Api::SkillsUsersController < ApplicationController
	before_action :authenticate_user
	
	def index
	end

	def create
		skills = params[:skills]
		@user = User.find_by(id: params[:idpeople]) || current_user
		begin
			ActiveRecord::Base.transaction do 
				skills.each do |skill|
					skill_create = Skill.find_by name: skill[:name]
					skill_create = Skill.create(name: skill[:name], user_id: @user.id) if skill_create.blank?
					skills_level = SkillsLevel.find_by! code: skill[:level]
					@user.skills_users.create! skill_id: skill_create.id, skills_level_id: skills_level.id
				end

			end
		rescue
			render json: {message: 'ocurrio un error'}, status: 400 and return
		end
		render json: {message: 'success'}, status: 201
	end
end

