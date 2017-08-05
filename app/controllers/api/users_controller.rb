class Api::UsersController < ApplicationController
	before_action :authenticate_user

	def index
		@search = params[:search]
		@order_by = params[:order_by]
		@users = User.all

		#filter search by name or lastname
		@users = @users.where("name like ? or lastname like ? ", "%#{@search}%", "#{@search}%") if @search.present?
		
		#filter order by
		if @order_by
			order = {"#{@order_by}": :desc}
			@users = @users.order(order)
		end
	end

	def create
		@user = User.new(params_user)
		@user.password = SecureRandom.hex(10)
		@rol = Rol.find_by(code: params[:idrol][:idrol])
		@user.rol_id = @rol.id
		if @user.save
			render json: {message: 'user has been created'}, status: 201
		else
			render json: @user.errors.details, status: 400
		end
	end

	def update
		params_update = params_user
		@user = User.find(params[:id])
		params_update[:rol_id] = params[:idrol][:idrol] if params[:idrol].present?
		if @user.update(params_update)
			render json: {message: 'user has been updated'}
		else
			render json: @user.errors.details, status: 400
		end
	end

	def show
		@user = User.find(params[:id])
	end

	private
	def params_user
		params.permit(:name, :rol_id, :lastname, :fotolink, :country, :city, :phone, :indate, :jobtitle, :email)
	end
end