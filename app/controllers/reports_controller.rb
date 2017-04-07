class ReportsController < ApplicationController
  # before_action :authorize_user

  # GET /reports
  # GET /reports.json
  def index
    @reports = firebase.get('/Reports').body
  end

  # GET /reports/new
  def new
  end

  # POST /reports
  # POST /reports.json
  def create
    @response=firebase.push("/Reports",{uid: current_user, body: params[:body]})

    respond_to do |format|
      if @response.success?
        format.html { redirect_to '/reports/new', notice: 'Report was successfully created.' }
      else
        format.html { redirect_to '/reports/new', notice: 'Erorr.' }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    firebase.delete("/Reports/"+params[:id])
    respond_to do |format|
      format.html { redirect_to reports_url, notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
