class PharmacistProfilesController < ApplicationController
  def index
  end

  def new
    @pharmacist_profile = PharmacistProfile.new
  end

  def create
    @pharmacist_profile = PharmacistProfile.new(pharmacist_profile_params)
    @pharmacist_profile.pharmacist_id = current_pharmacist.id
    if @pharmacist_profile.save
      flash[:notice] = "プロフィールを登録しました。"
      redirect_to pharmacist_pages_path
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
end
