class Api::SkillsController < ApplicationController
	before_action :authenticate_user

	def index
		@search = params[:search]
		@skills = Skill.includes(:user).order(name: :asc)
		#filter search by name
		@skills = Skill.includes(:user).where('lower(name) like ?', "%#{@search}%").order(name: :asc) if @search.present?
	end

	def levels
		@skills_levels = SkillsLevel.all
	end

	def create
		@skill = Skill.new(name: params_skill[:name].to_s.downcase)
		authorize @skill
		@skill.user_id = current_user.id
		if @skill.save
			render json: {message: 'success'}, status: 201
		else
			render json: @skill.errors.details, status: 400
		end
	end

	def update
		@skill = Skill.find(params[:id])
		authorize @skill
		if @skill.update(name: params_skill[:name].to_s.downcase)
			render json: {message: 'success'}
		else
			render json: @skill.errors.details, status: 400
		end
	end

	def show
		@skill = Skill.find(params[:id])
	end

	def destroy
		@skill = Skill.find(params[:id])
		authorize @skill
		render json: {message:'skill has been deleted'} if @skill.destroy
	end

	private
	def params_skill
		params.permit(:name)
	end
end
