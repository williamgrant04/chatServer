# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def logged_in?
    if current_user
      render json: { logged_in: true, user: current_user }, status: 200
    else
      render json: { logged_in: false }, status: 200
    end
  end

  private

  def respond_with(resource, _opts = {})
    puts resource
    render json: resource
  end

  def respond_to_on_destroy
    head :ok
  end
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
