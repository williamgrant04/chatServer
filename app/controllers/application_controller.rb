class ApplicationController < ActionController::API
  before_action :authenticate_user!
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized
  def not_authorized
    render json: { error: "You are not authorized to perform this action." }, status: 403
  end

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  def not_found
    render json: { error: "Record not found" }, status: 404
  end
end
