# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  before_action :configure_sign_up_params, only: [ :create ]
  before_action :configure_account_update_params, only: [ :update ]

  # POST /resource
  def create
    cl_response = Cloudinary::Uploader.upload(user_params[:image][:blob], folder: "chatapp/users")
    @user = User.new(user_params.except(:image))
    @user.image_public_id = cl_response["public_id"]

    if @user.save
      sign_in(@user) # I'm not exactly sure this does anything, but I've used it before in fullstack rails apps
      respond_with(@user)
    end
  end

  private

  def respond_with(resource, _opts = {})
    if resource.valid?
      render json: { user: UserSerializer.new(resource) }
    else
      errors = resource.errors.full_messages.map do |err|
        if err.downcase.include?("email") then
          { type: "email", message: err }
        elsif err.downcase.include?("username") then
          { type: "username", message: err }
        elsif err.downcase.include?("password") then
          { type: "password", message: err }
        end
      end.reject { |err| err[:message] == "Password can't be blank" } # No idea why devise does this

      if errors then
        render json: errors, status: 422, adapter: nil
      else
        render json: { errors: resource.errors.full_messages }, status: 422
      end
    end
  end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def user_params
    params.require(:user).permit([ :email, :password, :password_confirmation, :username, image: [ :type, :blob ] ])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :username ])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [ :username ])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
