class Api::ReportsController < ApplicationController
	def tags
		@tags =  params[:tags].split(',') if params[:tags].present?
		@skills = Skill.where("lower(name) in (?)", @tags)
		@tags =   @tags - @skills.map(&:name) # remove skills in tags
		@levels = SkillsLevel.where('lower(name) in (?)', @tags)
		@tags =   @tags - @levels.map(&:name) # remove levels in tags

		render json: [] and return if @tags.present?
		
		# if has only skills
		@users =  User
		.where('
			(select count(skill_id) from skills_users 
				where skills_users.user_id = users.id  and skills_users.skill_id in (?)) >= ?
		', @skills.pluck(:id), @skills.length
		) if @levels.blank? 

		# if has only level
		@users = User.where('
				(select count(skill_id) from skills_users 
					where skills_users.user_id = users.id  and skills_users.skills_level_id = ?) > 0
		',@levels.last.id) if @levels.present? and @skills.blank?


		# if has levels and skills 
		@users = User.where('
				(select count(skill_id) from skills_users 
					where skills_users.user_id = users.id  and skills_users.skill_id in (?) and skills_users.skills_level_id = ?) >= ?
		', @skills.pluck(:id),@levels.last.id, @skills.length) if @levels.present? and @skills.present?


		render json: @users
	end
end