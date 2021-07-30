class RoomsController < ApplicationController
  before_action :authenticate_user!

  def create
    @room = Room.new(room_params)
    if pharmacist_signed_in?
      @room.pharmacist_id = current_pharmacist.id
    elsif student_signed_in?
      @room.student_id = current_student.id
    end
    if @room.save
      redirect_to room_path(@room)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    @room = Room.find(params[:id])
    @message = Message.new
    @messages = @room.messages
    if pharmacist_signed_in?
      @student_profile = @room.student.student_profile
    elsif student_signed_in?
      @pharmacist_profile = @room.pharmacist.pharmacist_profile
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @relationship = Relationship.find_by(pharmacist_id: @room.pharmacist_id, student_id: @room.student_id)
    @room.destroy
    @relationship.destroy
    flash[:notice] = "トークルームを削除しました。"
    redirect_back(fallback_location: root_path)
  end

  private
    def room_params
      params.permit(:pharmacist_id, :student_id)
    end
end
