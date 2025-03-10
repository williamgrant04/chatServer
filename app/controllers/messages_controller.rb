class MessagesController < ApplicationController
  def index
    @channel = Channel.find(params[:channel_id])
    @messages = @channel.messages.includes(:author).order(created_at: :desc).limit(100).reverse

    render json: { messages: @messages.map { |message| MessageSerializer.new(message) } }, status: 200
  end

  def create
    @message = Message.new(message_params)
    @channel = Channel.find(params[:channel_id])
    @message.channel = @channel
    @message.author = current_user

    if @message.save
      MessageChannel.broadcast_to(@channel, { edit: false, message: MessageSerializer.new(@message) })
      head :ok
    else
      render json: { errors: @message.errors.full_messages }, status: 422
    end
  end

  def edit
    @message = Message.find(params[:id])
    @message.content = message_params[:content]

    if @message.save
      MessageChannel.broadcast_to(@message.channel, { edit: true, message: MessageSerializer.new(@message) })
      head :ok
    end
  end

  def destroy
    @message = Message.find(params[:id])

    if @message.destroy
      MessageChannel.broadcast_to(@message.channel, { destroy: true, message: MessageSerializer.new(@message) })
      head :ok
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
