class Api::UsersController < ApplicationController
	before_action :authenticate_user, except: [:forgot_password]

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
		password_randow = SecureRandom.hex(3)
		@user.password = password_randow
		@user.email= params_user[:email].to_s.downcase
		@rol = Rol.find_by(code: params[:idrol][:idrol])
		@user.rol_id = @rol.id
		if @user.save
			UserMailer.sending_password(@user,password_randow).deliver_now
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

	def destroy
		@user = User.find(params[:id])
		render json:{message:'User has been Delete'} if @user.destroy
	end
	
 	def forgot_password
		password_randow = SecureRandom.hex(3)
		@user = User.find_by(email:params_user[:email])
		if @user.present?
			@user.ischangepassword='T'
			@user.password = password_randow
			@user.save
			UserMailer.forgot_password(@user,password_randow).deliver_now
			render json: {message: 'Email has be sent'}
		else
			render json:{message: 'This email does not exist or is misspelled'}, status:404
		end
	end

	 def reset
		 @user= current_user
		 new_password = params[:password].to_s
		 render json: {status: false}, status: 422 and return if new_password.blank?
		 @user.password = new_password
		 @user.ischangepassword = 'F'
		 @user.save
		 render json:{message:'Password has be Change'}
	 end

	private
	def params_user
		params.permit(:name, :rol_id, :lastname, :fotolink, :country, :city, :phone, :indate, :jobtitle, :email)
	end
end
