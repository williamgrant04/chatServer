class ServersController < ApplicationController
  def index # Will need a list of servers related to a user
    @servers = current_user.servers
    render json: { servers: @servers }, status: 200
  end

  def show
    @server = Server.find(params[:id])

    render json: { server: @server }, status: 200
  end

  def create
    @server = Server.new(server_params)
    @server.user = current_user

    if @server.valid? && @server.save
      render json: { server: @server }, status: 201
    else
      render json: { errors: @server.errors.full_messages }, status: 422
    end
  end

  def edit
    @server = Server.find(params[:id])
    authorize @server
    @server.update(server_params)

    if @server.valid? && @server.save
      render json: { server: @server }, status: 200
    end
  end

  def destroy
    @server = Server.find(params[:id])
    authorize @server
    if @server.destroy
      render json: { message: "Server deleted" }, status: 200
    else
      render json: { error: "Server could not be deleted" }, status: 500 # An edge case but it may happen
    end
  end

  protected

  def server_params
    params.require(:server).permit(:name)
  end
end
