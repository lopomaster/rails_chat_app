require 'rails_helper'

RSpec.describe ChatRoomsController, type: :controller do

  before do
    @chat_room = create :chat_room
    @user = create :user

    cookie = ActionDispatch::Cookies::CookieJar.build(@request, cookies.to_h)
    cookie.signed[:user_name] = @user.name
    @request.cookies[:user_name] = cookie[:user_name]
  end

  describe "GET#index" do
    it 'populates an array of chat_rooms' do
      7.times do
        create :chat_room
      end
      process :index, method: :get
      expect(response).to have_http_status 200
      expect(response).to_not have_http_status 404
      expect(ChatRoom.count).to eq 8
      expect(ChatRoom.count).to_not eq 7
      expect(response).to render_template :index
    end
  end

  describe "POST#create" do
    it "creates a new chat_room" do
      expect{ post :create, xhr: true, params: { chat_room: FactoryGirl.attributes_for(:chat_room, title: 'title' ) } }.
          to change(ChatRoom, :count).by(1)
      expect(response).to render_template :create
    end

    it "cannot create a chat_room w/ nil attributes so it renders the :new template" do
      post :create, xhr: true, params: { chat_room: FactoryGirl.attributes_for(:chat_room, title: nil ) }
      expect(response).to render_template :new
    end
  end

  describe "PUT#update" do
    it "updates a chat_room" do
      put :update, xhr: true, params: { id: @chat_room.id, chat_room: FactoryGirl.attributes_for(:chat_room, title: 'new title') }
      @chat_room.reload
      expect(@chat_room.title).to eq 'new title'
      expect(response).to render_template :update
    end

    it "cannot update a chat_room w/ nil attributes so it renders the :edit template" do
      put :update, xhr: true, params: { id: @chat_room.id, chat_room: FactoryGirl.attributes_for(:chat_room, title: nil ) }
      @chat_room.reload
      expect(response).to render_template :edit
    end
  end

  describe "GET#show" do
    it "shows a chat_room" do
      process :show, method: :get, params: { id: @chat_room.id }
      expect(response).to have_http_status 200
      expect(response).to_not have_http_status 404
      expect(response).to render_template :show
    end
  end

  describe "DELETE#destroy" do
    it "deletes a chat_room" do
      delete :destroy, params: { id: @chat_room }
      expect{ ChatRoom.find @chat_room.id }.to raise_error Mongoid::Errors::DocumentNotFound
      expect(response).to have_http_status 302
      expect( response ).to redirect_to chat_rooms_url
    end
  end


  describe "Unsigned user" do

    before do
      @request.cookies[:user_name] = nil
    end

    it "cannot create chat_room without authorization" do
      expect{ post :create, xhr: true, params: { chat_room: FactoryGirl.attributes_for(:chat_room, title: 'title') }}.
          to change(ChatRoom, :count).by(0)
      expect(response).to have_http_status 200
      expect(response).to redirect_to root_path
    end

    it "cannot show chat_room without authorization" do
      process :show, method: :get, params: { id: @chat_room.id }
      expect(response).to have_http_status 302
      expect(response).to_not have_http_status 404
      expect(response).to redirect_to root_path
    end

    it "cannot delete a chat_room without authorization" do
      expect{delete :destroy, xhr: true, params: { id: @chat_room }}.to change(ChatRoom, :count).by(0)
      expect(response).to redirect_to root_path
    end

    it "cannot update a chat_room without authorization" do
      put :update, xhr: true, params: { id: @chat_room.id, chat_room: FactoryGirl.attributes_for(:chat_room, title: 'new title') }
      @chat_room.reload
      expect(@chat_room.title).to_not eq 'title'
      expect(response).to have_http_status 200
      expect(response).to redirect_to root_path
    end

  end

end



