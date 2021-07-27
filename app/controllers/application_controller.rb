class ApplicationController < ActionController::Base
  def authenticate_user!
    if !pharmacist_signed_in? && !student_signed_in?
      flash[:alert] = "ログインしてください。"
      redirect_to root_path
    elsif current_student && !current_student.student_profile
      flash[:alert] = "プロフィールを登録してください"
      redirect_to new_student_profile_path
    end
  end
end
