class Api::SkillsUsersController < ApplicationController
	before_action :authenticate_user

	def index
	end

	def show
		@user = User.find(params[:id])
		@skills = @user.skills_users.includes(:skill).order(skill_id: :desc)
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


	def update_skills
		skills = params[:skills]
		@user = User.find_by(id: params[:idpeople]) || current_user
		ActiveRecord::Base.transaction do
			begin
				skills.each do |skill|
					@level = SkillsLevel.find_by!(code: skill[:level])
					@user.skills_users.find_by!(skill_id: skill[:idskill]).update(skills_level_id: @level.id)
				end
			rescue
				render json: {message: 'failed'}, status: 400 and return
			end

		end
		render json: {message: 'success'}
	end

	def delete_skills
		SkillsUser.find_by!(user_id: params[:user_id], skill_id: params[:skill_id]).destroy
		render json: {message: 'success'}
	end
end
