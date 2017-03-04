class BusesController < ApplicationController
  before_action :authorize_admin
  # GET /buses
  # GET /buses.json
  def index
    @buses=firebase.get('/Buses').body
  end

  # GET /buses/new
  def new
    @bus = Bus.new
  end

  # POST /buses
  # POST /buses.json
  def create
    @bus = Bus.new()
    @response=firebase.push("/Buses",{number: bus_params[:number], route: bus_params[:route]})


    respond_to do |format|
      if @response.success?
        format.html { redirect_to @bus, notice: 'Bus was successfully created.' }
        format.json { render :show, status: :created, location: @bus }
      else
        format.html { render :new }
        format.json { render json: @bus.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /buses/1
  # PATCH/PUT /buses/1.json
  def update
    respond_to do |format|
      if @bus.update(bus_params)
        format.html { redirect_to @bus, notice: 'Bus was successfully updated.' }
        format.json { render :show, status: :ok, location: @bus }
      else
        format.html { render :edit }
        format.json { render json: @bus.errors, status: :unprocessable_entity }
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

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def bus_params
      params.require(:bus).permit(:number, :route)
    end
end
