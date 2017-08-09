class Api::ReportsController < ApplicationController
	def tags
		@tags =  params[:tags].split(',') if params[:tags].present?
		@skills = Skill.where("lower(name) in (?)", @tags)
		@tags =   @tags - @skills.map(&:name) # remove skills in tags
		@levels = SkillsLevel.where('lower(name) in (?)', @tags)
		@tags =   @tags - @levels.map(&:name) # remove levels in tags
		@countries = Country.where('lower(name) in (?)', @tags)
		@tags = @tags - @countries.map(&:name) #remove countries in tags
		# if has only skills
		@users =  User
		.includes(:rol,city: [:country])
		.joins(city: [:country])
		.where('
			(select count(skill_id) from skills_users
				where skills_users.user_id = users.id  and skills_users.skill_id in (?)) >= ?
		', @skills.pluck(:id), @skills.length
		) if @levels.blank?

		# if has only level
		@users = User.includes(:rol,city: [:country]).joins(city: [:country]).where('
				(select count(skill_id) from skills_users
					where skills_users.user_id = users.id  and skills_users.skills_level_id = ?) > 0
		',@levels.last.id) if @levels.present? and @skills.blank?


		# if has levels and skills
		@users = User.includes(:rol,city: [:country]).joins(city: [:country]).where('
				(select count(skill_id) from skills_users
					where skills_users.user_id = users.id  and skills_users.skill_id in (?) and skills_users.skills_level_id = ?) >= ?
		', @skills.pluck(:id),@levels.last.id, @skills.length) if @levels.present? and @skills.present?


		@users = @users.where(countries: {id: @countries.last.id}) if @countries.present?


		respond_to do |format|
			format.json do
				render json: [] and return if @tags.present?
				render :index
			end
			format.pdf {render pdf: 'hello', orientation: 'Landscape', footer: { right: '[page] / [topage]' }}
		end


	end
end
