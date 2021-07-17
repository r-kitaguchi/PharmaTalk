class PharmacistProfilesController < ApplicationController
  before_action :authenticate_pharmacist!, except: :index
  before_action :profile_unregistered, only: [:new, :create]

  def index
  end

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
  end

  def edit
  end

  def update
  end

  private

    def pharmacist_profile_params
      params.require(:pharmacist_profile).permit(:name, :image, :work_place, :work_place_type,
                                            :work_location, :university, :introduction)
    end

    def profile_unregistered
      if current_pharmacist.pharmacist_profile && current_pharmacist.pharmacist_profile.id
        redirect_to root_path
      end
    end

end
