class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    @message.is_pharmacist = true if pharmacist_signed_in?
    @message.save
    redirect_to room_path(@room)
  end

  private
    def message_params
      params.require(:message).permit(:content)
    end
end
