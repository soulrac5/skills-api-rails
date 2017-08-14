class Api::UsersController < ApplicationController
	before_action :authenticate_user, except: [:forgot_password]

	def index
		@search = params[:search]
		@order_by = params[:order_by]
		@users = User.includes(:rol, city: [:country]).order(name: :asc)

		#filter search by name or lastname
		@users = @users.where("lower(name) like ? or lower(lastname) like ? ", "%#{@search}%", "#{@search}%") if @search.present?
		@is_order_by_location =  @order_by == 'country'
		#filter order by
		if @order_by
			order = {"#{@order_by}": :asc}
			@users = @users.order(order) unless @is_order_by_location
			@users = User
			.includes(:rol, city: [:country])
			.joins(city: [:country])
			.order("countries.name asc") if @is_order_by_location
		end
	end

	def create
		@user = User.new(params_user)
		authorize @user
		password_randow = SecureRandom.hex(3)
		@user.password = password_randow
		@user.email= params_user[:email].to_s.downcase
		@rol = Rol.find_by(code: params[:idrol][:idrol])
		@user.rol_id = @rol.id
		if @user.save
			UserMailer.sending_password(@user,password_randow).deliver_now
			render :show
		else
			render json: @user.errors.details, status: 400
		end
	end

	def update
		params_update = params_user
		@user = User.find(params[:id])
		authorize @user
		params_update[:rol_id] = params[:idrol][:idrol] if params[:idrol].present?
		if @user.update(params_update)
			render :show
		else
			render json: @user.errors.details, status: 400
		end
	end

	def show
		@user = User.find(params[:id])
	end

	def destroy
		@user = User.find(params[:id])
		authorize @user
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
		params.permit(:name, :rol_id, :lastname, :fotolink,:city_id, :phone, :indate, :jobtitle, :email)
	end
end
