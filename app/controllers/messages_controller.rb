class MessagesController < ApplicationController
  before_action :set_chat_room, only: :create
  before_action :set_current_user, only: :create


  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    respond_to do |format|
      if @message.save
        format.html { redirect_to @chat_room, notice: "Message was successfully created." }
        format.js
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render 'chat_rooms/show' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def message_params
    params.require(:message).permit(:body).tap do |whitelisted|
      whitelisted[:chat_room_id] = @chat_room.id
      whitelisted[:user_id] = @current_user.id
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_chat_room
    @chat_room = ChatRoom.find(params[:chat_room_id])
  end

  def set_current_user
    @current_user = User.find_by( name: cookies.signed[:user_name])
  end

end
