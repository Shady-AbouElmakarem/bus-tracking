class AdminsController < ApplicationController
  before_action :authorize_master_admin, except: [:home, :account]
  before_action :authorize_admin, only: [:home, :account]

  # GET /admins/home
  def home

  end

  # GET /admins/account
  def account
    unless params[:new_password] == nil
      @response=firebase.account("/Admins/"+session[:admin_id],{password:params[:new_password]})
      respond_to do |format|
        if @response.success?
          format.html { redirect_to '/admins/account', notice: 'Password Changed successfully.' }
        else
          format.html { redirect_to '/admins/account', notice: 'Error.'}
        end
      end
    end
  end

  # GET /admins
  # GET /admins.json
  def index
    @admins=firebase.get('/Admins').body
  end

  # GET /admins/new
  def new
  end

  # POST /admins
  # POST /admins.json
  def create
    @response=firebase.push("/Admins",{name: params[:name], password: params[:password], master: params[:master]})

    respond_to do |format|
      if @response.success?
        format.html { redirect_to '/admins/new', notice: 'Admin was successfully created.' }
      else
        format.html { redirect_to '/admins/new', notice: 'Error.'}
      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    firebase.delete("/Admins/"+params[:id])
    respond_to do |format|
      format.html { redirect_to admins_url, notice: 'Admin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
