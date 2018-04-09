class UsersController < ApplicationController
  skip_before_action :user_login?, only: [:create, :new]

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :find_or_initialize, only: :create

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.json { render :json => @users.to_json( methods: [:destroyable]) }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    respond_to do |format|
      if @user.save
        set_current_user
        format.html { redirect_to chat_rooms_path(), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { redirect_to root_path }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    respond_to do |format|
      if @user.destroyable and @user.destroy
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { render :json => User.all }
      else
        format.html { redirect_to users_url, notice: 'User cannot be destroyed.' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name)
  end

  def find_or_initialize
    @user = User.find_or_initialize_by(user_params)
  end

  def set_current_user
    cookies.signed[:user_name] = @user.name
  end



end
