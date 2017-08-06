class Api::SkillsController < ApplicationController
	before_action :authenticate_user

	def index
		@search = params[:search]
		@skills = Skill.includes(:user)
		#filter search by name
		@skills = Skill.includes(:user).where('lower(name) like ?', "%#{@search}%") if @search.present?
	end

	def create
		@skill = Skill.new(params_skill)
		@skill.user_id = current_user.id
		if @skill.save
			render json: {message: 'skill has been created'}, status: 201
		else
			render json: @skill.errors.details, status: 400
		end
	end

	def update
		@skill = Skill.find(params[:id])
		render json: {message: 'success'} if @skill.update(params_skill)
	end

	def show
		@skill = Skill.find(params[:id])
	end

	private
	def params_skill
		params.permit(:name)
	end
end