class Api::LoginController < ApplicationController
	# get /api/login
	def index
	end

	#post /api/login
	def create
		@user = User.find_by email: params[:email]
		if @user && @user.authenticate(params[:password])
			@expire = Time.now.to_i + 30.days
			@jwt = Knock::AuthToken.new( payload: { sub: @user.id, exp: @expire })
			render json: {
				token: @jwt.token,
				expiration: Time.now + 30.days,
				id: @user.id
			}
		else
			render json: {message: 'username or password invalid', code: 100}, status: 400
		end
	end
end