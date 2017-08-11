class ApplicationController < ActionController::Base
  include Pundit
	# include Knock::Authenticable
  protect_from_forgery with: :null_session
  #rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found

  def authenticate_user
  	@token = request.headers['Authorization']
  	render json:  {}, status: 401 and return if @token .blank?
  	@token_auth = @token.split.last
  	@user_auth = User.find_by token: @token_auth
  	render json: {}, status: 401 and return  if @user_auth.present? and @user_auth.expire < DateTime.now
  	render json: {}, status: 401  and return if @user_auth.blank?
  end

  def current_user
  	@user_auth
  end

  def catch_not_found
    render json: {message:'resouce not found'},status:404 and return
  end

end
