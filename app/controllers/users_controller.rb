class UsersController < ApplicationController
  before_action :authorize_admin, except: [:home, :account]
  before_action :authorize_user, only: [:home, :account]
  require 'json'

  # GET /users/home
  def home
    @user= current_user.to_json;

  end

  # POST /users/account
  def account
    @bus=firebase.get('/buses/'+current_user["bus"]).body
    unless params[:new_password] == nil
      @response=firebase.update("/users/"+session[:user_id],{password:params[:new_password]})
      respond_to do |format|
        if @response.success?
          format.html { redirect_to '/users/account', notice: 'Password Changed successfully.' }
        else
          format.html { redirect_to '/users/account', notice: 'Error.'}
        end
      end
    end
    unless params[:pickUpLocation] == nil
      @response=firebase.update("/users/"+session[:user_id],{pickUpLocation: eval(params[:pickUpLocation])})
      respond_to do |format|
        if @response.success?
          format.html { redirect_to '/users/account', notice: 'Pickup Location Changed successfully.' }
        else
          format.html { redirect_to '/users/account', notice: 'Error.'}
        end
      end
    end

  end

  # GET /users
  # GET /users.json
  def index
    @users=firebase.get('/users').body
  end


  # GET /users/new
  def new
    @buses=firebase.get('/buses').body

  end

  # POST /users
  # POST /users.json
  def create
    @response=firebase.set("/users/"+params[:uid],{uid: params[:uid], name: params[:name], first: true, password: "12345", bus: params[:bus], pickUpLocation: {"name" => "","lat" => "","lng" => ""}})

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
    firebase.delete("/users/"+params[:id])
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully Deleted.' }
    end
  end
end
