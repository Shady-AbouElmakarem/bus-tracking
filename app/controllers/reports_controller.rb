class ReportsController < ApplicationController
  before_action :authorize_user, only: [:new, :create]
  before_action :authorize_admin, only: [:index, :destroy]


  # GET /reports
  def index
    @reports = firebase.get('/Reports').body
  end

  # GET /reports/new
  def new
  end

  # POST /reports
  def create
    @response=firebase.push("/Reports",{uid: current_user["uid"], problem: params[:problem]})

    respond_to do |format|
      if @response.success?
        format.html { redirect_to '/reports/new', notice: 'Report was successfully created.' }
      else
        format.html { redirect_to '/reports/new', notice: 'Erorr.' }
      end
    end
  end

  # DELETE /reports/1
  def destroy
  #   firebase.delete("/Reports/"+params[:id])
  #   respond_to do |format|
  #     format.html { redirect_to reports_url, notice: 'Report was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  end
end
