class Api::SkillsController < ApplicationController
	before_action :authenticate_user

	def index
		@skills = Skill.all
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
	end

	def show
		@skill = Skill.find(params[:id])
	end

	private
	def params_skill
		params.permit(:name)
	end
end