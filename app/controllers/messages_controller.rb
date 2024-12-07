class MessagesController < ApplicationController
  def index
    @channel = Channel.find(params[:channel_id])
    @messages = @channel.messages.includes(:author).order(created_at: :asc).limit(100)

    render json: { messages: @messages.map { |message| MessageSerializer.new(message) } }, status: 200
  end

  def create
    @message = Message.new(message_params)
    @channel = Channel.find(params[:channel_id])
    @message.channel = @channel
    @message.author = current_user

    if @message.save
      ChannelChannel.broadcast_to(@channel, MessageSerializer.new(@message))
      head :ok
    else
      render json: { errors: @message.errors.full_messages }, status: 422
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
