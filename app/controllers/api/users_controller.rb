class Api::UsersController < ApplicationController
	before_action :authenticate_user

	def index
		@users = User.all
	end

	def create
		@user = User.new(params_user)
		@user.password = SecureRandom.hex(10)
		if @user.save
			render json: {message: 'user has been created'}, status: 201
		else
			render json: @user.errors.details, status: 400
		end
	end

	def show
		@user = User.find(params[:id])
	end

	private
	def params_user
		params.permit(:name, :rol_id, :lastname, :fotolink, :country, :city, :phone, :indate, :jobtitle)
	end
end