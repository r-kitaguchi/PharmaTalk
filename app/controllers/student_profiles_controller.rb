class StudentProfilesController < ApplicationController
  before_action :authenticate_student!, except: :index
  before_action :profile_unregistered, only: [:new, :create]

  def index
  end

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
  end

  def edit
  end

  def update
  end

  private

    def student_profile_params
      params.require(:student_profile).permit(:name, :image, :university, :year, :introduction)
    end

    def profile_unregistered
      if current_student.student_profile && current_student.student_profile.id
        redirect_to root_path
      end
    end
end
