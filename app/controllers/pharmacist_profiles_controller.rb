class PharmacistProfilesController < ApplicationController
  before_action :authenticate_pharmacist!, except: [:search, :show]
  before_action :authenticate_user!, only: [:show]
  before_action :profile_unregistered, only: [:new, :create]
  before_action :correct_pharmacist, only: [:edit, :update]

  def new
    @pharmacist_profile = PharmacistProfile.new
  end

  def create
    @pharmacist_profile = current_pharmacist.build_pharmacist_profile(pharmacist_profile_params)
    if @pharmacist_profile.save
      flash[:notice] = "プロフィールを登録しました。"
      redirect_to pharmacist_path(current_pharmacist)
    else
      render "new"
    end
  end

  def show
    @pharmacist_profile = PharmacistProfile.find(params[:id])
  end

  def edit
  end

  def update
    if @pharmacist_profile.update(pharmacist_profile_params)
      flash[:notice] = "プロフィールを更新しました。"
      redirect_to pharmacist_path(current_pharmacist)
    else
      render "edit"
    end
  end

  def search
    @q = PharmacistProfile.ransack(params[:q])
    @q.sorts = 'id desc' if @q.sorts.empty?
    @results = @q.result.page(params[:page]).per(10)
  end


  private

    def pharmacist_profile_params
      params.require(:pharmacist_profile).permit(:name, :image, :work_place, :work_place_type,
                                            :work_location, :university, :introduction, :remove_image)
    end

    def profile_unregistered
      if current_pharmacist.pharmacist_profile && current_pharmacist.pharmacist_profile.id
        redirect_to root_path
      end
    end

    def authenticate_user!
      if !pharmacist_signed_in? && !student_signed_in?
        flash[:alert] = "ログインしてください。"
        redirect_to root_path
      elsif current_student && !current_student.student_profile
        flash[:alert] = "プロフィールを登録してください"
        redirect_to new_student_profile_path
      end
    end

    def correct_pharmacist
      @pharmacist_profile = PharmacistProfile.find(params[:id])
      unless @pharmacist_profile == current_pharmacist.pharmacist_profile
        redirect_to root_path
      end
    end
end
