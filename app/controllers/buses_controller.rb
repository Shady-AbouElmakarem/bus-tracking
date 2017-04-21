class BusesController < ApplicationController
  before_action :authorize_admin

  # GET /live
  def live_feed
    @buses=firebase.get('/buses').body
  end

  # GET /buses
  def index
    @buses=firebase.get('/buses').body
  end

  # GET /buses/new
  def new
  end

  # POST /buses
  def create
    @response = firebase.push("/buses",{busid: params[:busid], route: params[:locations]})
    respond_to do |format|
      if @response.success?
        format.html { redirect_to '/buses/new', notice: 'Bus was successfully created.' }
      else
        format.html { redirect_to '/buses/new', notice: 'Error' }
      end
    end
  end

  # DELETE /buses/1
  def destroy
    firebase.delete("/buses/"+params[:id])
    respond_to do |format|
      format.html { redirect_to buses_url, notice: 'Bus was successfully Deleted.' }
    end
  end
end
