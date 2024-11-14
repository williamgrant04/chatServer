class ServersController < ApplicationController
  def index # Will need a list of servers related to a user
    @servers = Server.all
    # current_user.servers will be what is used when it's implemented properly. But for now I'm just testing through postman.
    render json: { servers: @servers }, status: 200
  end

  def show
    @server = Server.find(params[:id])

    render json: { server: @server }, status: 200
  end

  def create
    @server = Server.new(server_params)

    if @server.valid? && @server.save
      render json: { server: @server }, status: 201
    else
      render json: { errors: @server.errors.full_messages }, status: 422
    end
  end

  def edit
    @server = Server.find(params[:id])
    @server.update(server_params)

    if @server.valid? && @server.save
      render json: { server: @server }, status: 200
    end
  end

  def destroy
    @server = Server.find(params[:id])
    @server.destroy
  end

  protected

  def server_params
    params.require(:server).permit(:name)
  end
end
