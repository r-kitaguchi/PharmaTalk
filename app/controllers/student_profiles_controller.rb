class StudentProfilesController < ApplicationController
  before_action :authenticate_student!, except: :index
  def index
  end

  def new
    @student_profile = StudentProfile.new
  end

  def create
    @student_profile = current_student.build_student_profile(student_params)
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

    def student_params
      params.require(:student_profile).permit(:name, :image, :university, :year, :introduction)
    end
end
