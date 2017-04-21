class ComplaintsController < ApplicationController
  before_action :authorize_user, only: [:new, :create]
  before_action :authorize_admin, only: [:index, :destroy]


  # GET /complaints
  def index
    @complaints = firebase.get('/complaints').body
  end

  # GET /complaints/new
  def new
  end

  # POST /complaints
  def create
    @response=firebase.push("/complaints",{uid: current_user["uid"], complaint: params[:complaint]})

    respond_to do |format|
      if @response.success?
        format.html { redirect_to '/complaints/new', notice: 'complaint was successfully created.' }
      else
        format.html { redirect_to '/complaints/new', notice: 'Erorr.' }
      end
    end
  end

  # DELETE /complaints/1
  def destroy
    firebase.delete("/complaints/"+params[:id])
    respond_to do |format|
      format.html { redirect_to complaints_url, notice: 'Complaint was successfully Deleted.'}
    end
  end
end
