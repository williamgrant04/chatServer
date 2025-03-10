class ServerChannel < ApplicationCable::Channel
  def subscribed
    stream_from "server_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
