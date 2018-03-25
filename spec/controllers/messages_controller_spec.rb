require 'rails_helper'

RSpec.describe MessagesController, type: :controller do

  before do
    @message = create :message
    @user = create :user
    @chat_room = create :chat_room

    cookie = ActionDispatch::Cookies::CookieJar.build(@request, cookies.to_h)
    cookie.signed[:user_name] = @user.name
    @request.cookies[:user_name] = cookie[:user_name]
  end

  describe "POST#create" do
    it "creates a new message" do
      expect{ post :create, xhr: true, params: { chat_room_id: @chat_room.id, message: FactoryGirl.attributes_for(:message, body: 'body' ) } }.
          to change(Message, :count).by(1)
      expect(response).to render_template :create
    end

    it "cannot create a message w/ nil attributes so it renders the :new template" do
      post :create, xhr: true, params: { chat_room_id: @chat_room.id, message: FactoryGirl.attributes_for(:message, body: nil ) }
      expect(response).to render_template :show
    end
  end

  describe "Unsigned user" do

    before do
      @request.cookies[:user_name] = nil
    end

    it "cannot create message without authorization" do
      expect{ post :create, xhr: true, params: { chat_room_id: @chat_room.id, message: FactoryGirl.attributes_for(:message, body: 'body') }}.
          to change(Message, :count).by(0)
      expect(response).to have_http_status 200
      expect(response).to redirect_to root_path
    end

  end

end



