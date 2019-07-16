class MessagesController < ApplicationController

  before_action :authenticate_user!

  def show
    if MessageThread.between(current_user.id,param_id).present?
      @message_thread = MessageThread.between(current_user.id, param_id).first
    else
      @message_thread = MessageThread.create!({sender_id: current_user.id, receiver_id: param_id})
    end

    @messages = @message_thread.messages
    @message = Message.new
  end

  def new
    @message = Message.new
  end

  def create
    @message_thread = MessageThread.between(current_user.id, param_id).first
    @message = current_user.messages.create(msg_params)
    @message.message_thread_id = @message_thread.id
    if @message.save
      ActionCable.server.broadcast 'room_channel', content: @message.try(:content),
                                                   name: @message.user.try(:username),
                                                   is_darker: ( "darker" if (current_user.id == @message.user.id)),
                                                   img_pst: ( "right" if (current_user.id == @message.user.id)),
                                                   time_frame: ( (current_user.id == @message.user.id) ? "time-right" :"time-left" ),
                                                   img: @message.user.gravatar_url,
                                                   room_id: "#msg_thread_#{@message_thread.id}"
    end
  end

  private
  def msg_params
    params.require(:message).permit(:content)
  end

  def param_id
    params[:id]
  end

end
