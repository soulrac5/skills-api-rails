class Api::LoginController < ApplicationController
	# get /api/login
	def index
	end

	#post /api/login
	def create
		@user = User.find_by email: params[:email].to_s.downcase
		if @user && @user.authenticate(params[:password])
			@expire = DateTime.now + 30.days
			@user.token = SecureRandom.hex(10)
			@user.expire = @expire
			@user.save!
			render json: {
				token: @user.token,
				expiration: @user.expire,
				id: @user.id
			}
		else
			render json: {message: 'username or password invalid', code: 100}, status: 400
		end
	end
end