class MessagesRelayJob < ApplicationJob

  def perform(message_id)
    html_results = {}
    message = Message.find message_id
    chat_room = message.chat_room
    if message.present?
      html_results["#chat_room_messages_#{chat_room.id}"] = render_message message
      ActionCable.server.broadcast "messages:#{chat_room.id}:chat_rooms", html_results: html_results.to_json.html_safe
    end
  end

  private

  def render_message(message)
    ApplicationController.render partial: 'messages/message', locals: {message: message}
  end

end