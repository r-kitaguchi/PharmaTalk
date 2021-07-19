class PharmacistProfilesController < ApplicationController
  before_action :authenticate_pharmacist!, except: :search
  before_action :profile_unregistered, only: [:new, :create]

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
    @pharmacist_profile = PharmacistProfile.find_by(pharmacist_id: current_pharmacist.id)
  end

  def edit
    @pharmacist_profile = PharmacistProfile.find_by(pharmacist_id: current_pharmacist.id)
  end

  def update
    @pharmacist_profile = PharmacistProfile.find_by(pharmacist_id: current_pharmacist.id)
    if @pharmacist_profile.update(pharmacist_profile_params)
      flash[:notice] = "プロフィールを更新しました。"
      redirect_to pharmacist_path(current_pharmacist)
    else
      render "edit"
    end
  end

  def search
    @q = PharmacistProfile.ransack(params[:q])
    @results = @q.result
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
end
