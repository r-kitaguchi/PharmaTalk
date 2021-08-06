class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    @message.is_pharmacist = true if pharmacist_signed_in?
    @message.save
    Notification.create(message_id: @message.id, pharmacist_id: @room.pharmacist_id,
                      student_id: @room.student_id, is_pharmacist: @message.is_pharmacist)
  end

  private
    def message_params
      params.require(:message).permit(:content)
    end
end
