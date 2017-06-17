class AdminsController < ApplicationController
  before_action :authorize_admin

  # GET /admins/account
  def account
    unless params[:new_password] == nil
      @response=firebase.update("/admins/"+session[:admin_id],{password:params[:new_password]})
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
    @admins=firebase.get('/admins').body
  end

  # GET /admins/new
  def new
  end

  # POST /admins
  # POST /admins.json
  def create
    @response=firebase.push("/admins",{name: params[:name], password: params[:password]})

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
    firebase.delete("/admins/"+params[:id])
    respond_to do |format|
      format.html { redirect_to admins_url, notice: 'Admin was successfully Deleted.' }
    end
  end
end
