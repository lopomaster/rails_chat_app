class ChatRoomsController < ApplicationController
  before_action :set_chat_room, only: [:edit, :update, :destroy]
  before_action :set_chat_rooms, only: :index

  # GET /chat_rooms
  # GET /chat_rooms.json
  def index
  end

  # GET /chat_rooms/1
  # GET /chat_rooms/1.json
  def show
    @chat_room = ChatRoom.includes(:messages).find_by(id: params[:id])
    @message = Message.new
  end

  # GET /chat_rooms/new
  def new
    @chat_room = ChatRoom.new
  end

  # GET /chat_rooms/1/edit
  def edit
  end

  # POST /chat_rooms
  # POST /chat_rooms.json
  def create
    @chat_room = ChatRoom.new(chat_room_params)

    respond_to do |format|
      if @chat_room.save
        set_chat_rooms
        format.html { redirect_to chat_rooms_path, notice: 'Chat room was successfully created.' }
        format.js { render :create }
        format.json { render :show, status: :created, location: @chat_room }
      else
        format.js { render :new }
        format.json { render json: @chat_room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chat_rooms/1
  # PATCH/PUT /chat_rooms/1.json
  def update
    respond_to do |format|
      if @chat_room.update(chat_room_params)
        format.html { redirect_to chat_rooms_path, notice: 'Chat room was successfully updated.' }
        format.js { render :update }
        format.json { render :index, status: :ok, location: @chat_room }
      else
        format.html { render :edit }
        format.js { render :edit }
        format.json { render json: @chat_room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chat_rooms/1
  # DELETE /chat_rooms/1.json
  def destroy
    respond_to do |format|
      if @chat_room.messages.empty? and @chat_room.destroy
        format.html { redirect_to chat_rooms_url, notice: 'Chat room was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to chat_rooms_url, notice: 'Chat room cannot be destroyed.' }
        format.json { render json: @chat_room.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_chat_room
    @chat_room = ChatRoom.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def chat_room_params
    params.require(:chat_room).permit(:title)
  end

  def set_chat_rooms
    @chat_rooms = ChatRoom.all
  end

end
