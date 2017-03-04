class AdminsController < ApplicationController
  before_action :authorize_master_admin, except: [:home]
  before_action :authorize_admin, only: [:home]

  # GET /users/home
  def home
  end

  # GET /admins
  # GET /admins.json
  def index
    @admins=firebase.get('/Admins').body
  end

  # GET /admins/new
  def new
    @admin= Admin.new
  end

  # POST /admins
  # POST /admins.json
  def create
    @admin = Admin.new()
    @response=firebase.push("/Admins",{name: admin_params[:name], password: admin_params[:password], master: admin_params[:master]})

    respond_to do |format|
      if @response.success?
        format.html { redirect_to @admin, notice: 'Admin was successfully created.' }
        format.json { render :show, status: :created, location: @admin }
      else
        format.html { render :new }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def update
    respond_to do |format|
      if @admin.update(admin_params)
        format.html { redirect_to @admin, notice: 'Admin was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html { render :edit }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
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

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      params.require(:admin).permit(:name, :password, :master)
    end
end
