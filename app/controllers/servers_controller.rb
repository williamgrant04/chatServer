class ServersController < ApplicationController
  def index # Will need a list of servers related to a user
    @servers = current_user.servers
    render json: { servers: @servers.map { |server| ServerSerializer.new(server) } }, status: 200
  end

  def show
    @server = Server.find(params[:id])
    # find_by not where because this should just return the specific serveruser
    @server_users = ServerUser.find_by(user: current_user, server: @server)
    authorize(@server_users, :show?, policy_class: ServerPolicy)

    render json: { server: ServerSerializer.new(@server) }, status: 200
  end

  def create
    @server = Server.new(server_params)
    @server.owner = current_user

    if @server.valid? && @server.save
      render json: { server: ServerSerializer.new(@server) }, status: 201
    else
      render json: { errors: @server.errors.full_messages }, status: 422
    end
  end

  def update
    @server = Server.find(params[:id])
    authorize @server
    @server.update(server_params)

    if @server.valid? && @server.save
      render json: { server: ServerSerializer.new(@server) }, status: 200
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
