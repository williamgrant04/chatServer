class ChannelsController < ApplicationController
  def index
    @server = Server.find(params[:server_id])
    # find_by not where because this should just return the specific serveruser
    @server_users = ServerUser.find_by(user: current_user, server: @server)
    authorize(@server_users, :index?, policy_class: ChannelPolicy) # This is kinda monekey-patched

    render json: { channels: @server.channels }, status: 200
  end

  def show
    @channel = Channel.find_by(server_id: params[:server_id], id: params[:channel_id])

    return render json: { error: "Channel not found" }, status: 404 if @channel.nil?
    # @channel = Channel.find(params[:id])
    @server_users = ServerUser.find_by(user: current_user, server: @channel.server)
    authorize(@server_users, :show?, policy_class: ChannelPolicy)

    render json: { channel: @channel }, status: 200
  end

  def create
    @server = Server.find(params[:server_id])
    @channel = Channel.new(channel_params)
    @channel.server = @server
    authorize @channel

    if @channel.valid? && @channel.save
      ChannelChannel.broadcast_to(@server, { channel: @channel })
    else
      render json: { errors: @channel.errors.full_messages }, status: 422
    end
  end

  def update
    @channel = Channel.find(params[:id])
    @channel.update(channel_params)

    if @channel.valid? && @channel.save
      render json: { channel: @channel }, status: 200
    else
      render json: { errors: @channel.errors.full_messages }, status: 422
    end
  end

  def destroy
    @channel = Channel.find(params[:id])

    if @channel.destroy
      ChannelChannel.broadcast_to(@channel.server, { destroy: true, channel: @channel })
      head 200
    else
      render json: { error: "Channel could not be deleted" }, status: 500
    end
  end

  protected

  def channel_params
    params.require(:channel).permit(:name)
  end
end
