class ApplicationController < ActionController::API
  include ActionController::Cookies
  before_action :authorized
  # before_action :validate

  def authorized
    return render json: {error: "Not authorized"}, status: :unauthorized unless session.include? :user_id
  end

  # def validate(invalid)
  #   render json: {error: invalid.record.errors.full_messages}, status: :unprocessable_entity
  # end

end
