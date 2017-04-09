class UsersController < ApplicationController
  before_action :authorize_admin, except: [:home, :account]
  before_action :authorize_user, only: [:home, :account]

  # GET /users/home
  def home

  end

  # POST /users/account
  def account
    unless params[:new_password] == nil
      @response=firebase.update("/Users/"+session[:user_id],{password:params[:new_password]})
      respond_to do |format|
        if @response.success?
          format.html { redirect_to '/users/account', notice: 'Password Changed successfully.' }
        else
          format.html { redirect_to '/users/account', notice: 'Error.'}
        end
      end
    end
  end

  # GET /users
  # GET /users.json
  def index
    @users=firebase.get('/Users').body
  end


  # GET /users/new
  def new
  end

  # POST /users
  # POST /users.json
  def create
    @response=firebase.push("/Users",{uid: params[:uid], password: "12345", bus: params[:bus], pickUpLocation: "29.9760137,30.9476715"})

    respond_to do |format|
      if @response.success?
        format.html { redirect_to '/users/new', notice: 'User was successfully created.' }
      else
        format.html { redirect_to '/users/new', notice: 'Error.' }
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
end
