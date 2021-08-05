# frozen_string_literal: true

class Students::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  def new_guest
    student = Student.guest
    sign_in student
    if student.student_profile
      redirect_to student_path(student)
    else
      redirect_to new_student_profile_path
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
    if resource.student_profile
      student_path(resource)
    else
      new_student_profile_path
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
