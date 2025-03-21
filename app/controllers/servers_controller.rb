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

  def invite
    @server = Server.find(params[:id]) # Might make an "invite codes" table or something, allowing multiple invite codes per server
    @server_user = ServerUser.find_by(user: current_user, server: @server)

    if @server_user.nil? then
      @server_user = ServerUser.new(user: current_user, server: @server)

      if @server_user.save
        ActionCable.server.broadcast("server_channel", ServerSerializer.new(@server))
        head 200
      else
        render json: { errors: @server_user.errors.full_messages }, status: 422
      end
    else
      render json: { error: "User already exists on server" }, status: 400
    end
  end

  def create
    @server = Server.new(server_params.except(:image))
    @server.owner = current_user
    cl_response = Cloudinary::Uploader.upload(server_params[:image][:blob], folder: "chatapp/servers")
    @server.image_public_id = cl_response["public_id"]

    if @server.valid? && @server.save
      ActionCable.server.broadcast("server_channel", ServerSerializer.new(@server))
      head :ok
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
    params.require(:server).permit(:name, image: [ :type, :blob ])
  end
end
