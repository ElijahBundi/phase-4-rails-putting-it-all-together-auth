class UsersController < ApplicationController
    wrap_parameters format: []
    skip_before_action :authorized, only: [:create]
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

    # Signing up
    def create
        user = User.create!(user_params)
        session[:user_id] ||= user.id
        render json: user, status: :created
    end

    # Auto-logging in
    def show
        user = User.find(session[:user_id])
        render json: user, status: :created
    end

    private

    def render_unprocessable_entity(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def user_params
        params.permit(:username, :password, :password_confirmation, :image_url, :bio)
    end

end
