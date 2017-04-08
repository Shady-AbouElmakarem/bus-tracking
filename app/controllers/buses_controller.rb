class BusesController < ApplicationController
  before_action :authorize_admin

  # GET /buses
  # GET /buses.json
  def index
    @buses=firebase.get('/Buses').body
  end

  # GET /buses/new
  def new
  end

  # POST /buses
  # POST /buses.json
  def create
    @response = firebase.push("/Buses",{number: params[:number]})
    respond_to do |format|
      if @response.success?
        params[:points].each do |index, value|
          @response2 = firebase.set("/Buses/"+@response.body["name"].to_s+"/point_"+index.to_s, value.to_s)
          unless @response.success?
            format.html { redirect_to '/buses/new', notice: 'Error' }
            break
          end
        end
        format.html { redirect_to '/buses/new', notice: 'Bus was successfully created.' }
      else
        format.html { redirect_to '/buses/new', notice: 'Error' }
      end
    end
  end

  # DELETE /buses/1
  # DELETE /buses/1.json
  def destroy
    firebase.delete("/Buses/"+params[:id])
    respond_to do |format|
      format.html { redirect_to buses_url, notice: 'Bus was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
