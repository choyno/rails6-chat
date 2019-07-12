class MessagesController < ApplicationController

  before_action :authenticate_user!

  def new
    @message = Message.new
  end

  def create
    @message = current_user.messages.create(msg_params)
    if @message.save
      ActionCable.server.broadcast 'room_channel', content: @message.try(:content), name: @message.user.try(:username)
    end
  end

  private
  def msg_params
    params.require(:message).permit(:content)
  end

end
