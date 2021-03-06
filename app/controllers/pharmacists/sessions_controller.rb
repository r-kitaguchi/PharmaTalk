# frozen_string_literal: true

class Pharmacists::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  def new_guest
    pharmacist = Pharmacist.guest
    sign_in pharmacist
    if pharmacist.pharmacist_profile
      redirect_to pharmacist_path(pharmacist)
    else
      redirect_to new_pharmacist_profile_path
    end
  end

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

  protected

  def after_sign_in_path_for(resource)
    if resource.pharmacist_profile
      pharmacist_path(resource)
    else
      new_pharmacist_profile_path
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
