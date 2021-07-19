class StudentProfilesController < ApplicationController
  before_action :authenticate_student!
  before_action :profile_unregistered, only: [:new, :create]

  def new
    @student_profile = StudentProfile.new
  end

  def create
    @student_profile = current_student.build_student_profile(student_profile_params)
    if @student_profile.save
      flash[:notice] = "プロフィールを登録しました。"
      redirect_to student_path(current_student)
    else
      render "new"
    end
  end

  def show
    @student_profile = StudentProfile.find_by(student_id: current_student.id)
  end

  def edit
    @student_profile = StudentProfile.find_by(student_id: current_student.id)
  end

  def update
    @student_profile = StudentProfile.find_by(student_id: current_student.id)
    if @student_profile.update(student_profile_params)
      flash[:notice] = "プロフィールを更新しました。"
      redirect_to student_path(current_student)
    else
      render "edit"
    end
  end

  private

    def student_profile_params
      params.require(:student_profile).permit(:name, :image, :university, :year, :introduction, :remove_image)
    end

    def profile_unregistered
      if current_student.student_profile && current_student.student_profile.id
        redirect_to root_path
      end
    end
end
