class MessagesChannel < ApplicationCable::Channel

  def follow(data)
    stop_all_streams
    stream_from "messages:#{data['chat_room_id']}:chat_rooms"
    puts 'ChatRoom Messages: Following'
  end

  def unfollow
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end

end