class ChannelsController < ApplicationController
  def index
    @server = Server.find(params[:server_id])
    @channels = @server.channels

    render json: { channels: @channels }, status: 200
  end

  def show
    @channel = Channel.find(params[:id])

    render json: { channel: @channel }, status: 200
  end

  def create
    @server = Server.find(params[:server_id])
    @channel = Channel.new(channel_params)
    @channel.server = @server

    if @channel.valid? && @channel.save
      render json: { channel: @channel }, status: 201
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

  def delete
    @channel = Channel.find(params[:id])

    if @channel.destroy
      render json: { message: "Channel deleted" }, status: 200
    else
      render json: { error: "Channel could not be deleted" }, status: 500
    end
  end
end
