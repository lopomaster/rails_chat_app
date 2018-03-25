require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before do
    @user = create :user

    cookie = ActionDispatch::Cookies::CookieJar.build(@request, cookies.to_h)
    cookie.signed[:user_name] = @user.name
    @request.cookies[:user_name] = cookie[:user_name]
  end

  describe "GET#index" do
    it 'populates an array of users' do
      7.times do
        create :user
      end
      process :index, method: :get
      expect(response).to have_http_status 200
      expect(response).to_not have_http_status 404
      expect(User.count).to eq 8
      expect(User.count).to_not eq 7
      expect(response).to render_template :index
    end
  end

  describe "POST#create" do
    it "creates a new user" do
      expect{ post :create, params: { user: FactoryGirl.attributes_for(:user, name: 'name' ) } }.
          to change(User, :count).by(1)
      expect(response).to redirect_to chat_rooms_url
    end

    it "cannot create a user w/ nil attributes so it renders the :new template" do
      expect{ post :create, params: { user: FactoryGirl.attributes_for(:user, name: nil ) } }.
          to change(User, :count).by(0)
      expect(response).to render_template :new
    end
  end

  describe "PUT#update" do
    it "updates a user" do
      put :update, params: { id: @user.id, user: FactoryGirl.attributes_for(:user, name: 'new name') }
      @user.reload
      expect(@user.name).to eq 'new name'
      expect(response).to have_http_status 302
      expect(response).to redirect_to user_url
    end

    it "cannot update a user w/ nil attributes so it renders the :edit template" do
      put :update, xhr: true, params: { id: @user.id, user: FactoryGirl.attributes_for(:user, name: nil ) }
      @user.reload
      expect(response).to render_template :edit
    end
  end

  describe "GET#show" do
    it "shows a user" do
      process :show, method: :get, params: { id: @user.id }
      expect(response).to have_http_status 200
      expect(response).to_not have_http_status 404
      expect(response).to render_template :show
    end
  end

  describe "DELETE#destroy" do
    it "deletes a user" do
      delete :destroy, params: { id: @user }
      expect{ ChatRoom.find @user.id }.to raise_error Mongoid::Errors::DocumentNotFound
      expect(response).to have_http_status 302
      expect( response ).to redirect_to users_url
    end
  end


  describe "Unsigned user" do

    before do
      @request.cookies[:user_name] = nil
    end

    it "can create user" do
      expect{ post :create, xhr: true, params: { user: FactoryGirl.attributes_for(:user, title: 'title') }}.
          to change(ChatRoom, :count).by(0)
      expect(response).to have_http_status 200
      expect(response).to_not have_http_status 404
      expect(response).to redirect_to chat_rooms_path
    end


    it "cannot show user without authorization" do
      process :show, method: :get, params: { id: @user.id }
      expect(response).to have_http_status 302
      expect(response).to_not have_http_status 404
      expect(response).to redirect_to root_path
    end

    it "cannot delete a user without authorization" do
      expect{delete :destroy, xhr: true, params: { id: @user }}.to change(ChatRoom, :count).by(0)
      expect(response).to redirect_to root_path
    end

    it "cannot update a user without authorization" do
      put :update, xhr: true, params: { id: @user.id, user: FactoryGirl.attributes_for(:user, name: 'new name') }
      @user.reload
      expect(@user.name).to_not eq 'new name'
      expect(response).to have_http_status 200
      expect(response).to redirect_to root_path
    end

  end

end



