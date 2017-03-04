class UsersController < ApplicationController
  before_action :authorize_admin, except: [:home]
  before_action :authorize_user, only: [:home]
  # GET /users/home
  def home

  end


  # GET /users
  # GET /users.json
  def index
    @users=firebase.get('/Users').body
  end


  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new()
    @response=firebase.push("/Users",{uid: user_params[:uid], password: 12345, bus: user_params[:bus]})

    respond_to do |format|
      if @response.success?
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
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
    firebase.delete("/Users/"+params[:id])
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:uid, :bus)
    end
end
