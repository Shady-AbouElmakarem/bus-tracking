class BusesController < ApplicationController
  before_action :authorize_admin

  # GET /live
  def live_feed
    @buses=firebase.get('/live').body
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
    locations = params[:locations]
    route = Array.new(locations.length){Hash.new(3)}
    locations.each_with_index do |location, index|
      if (index+1)%3==0
        route[((index.to_i+1)/3)-1]["name"]= locations[index.to_i-2]
        route[((index.to_i+1)/3)-1]["lat"]= locations[index.to_i-1]
        route[((index.to_i+1)/3)-1]["lng"]= locations[index.to_i]
      end
    end
    @response = firebase.set("/buses/"+params[:busid], route)
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
