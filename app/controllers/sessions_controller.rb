class SessionsController < ApplicationController
  before_action :logged_user_or_admin, except: [:destroy_admin, :destroy_user]
  before_action :authorize_user, only: [:destroy_user]
  before_action :authorize_admin, only: [:destroy]

  layout "sessions.html.erb"

  def new_admin
  end

  def login_admin
    @admin_id = find_id(firebase.get("/Admins").body,"name",params[:name])
    unless @admin_id == nil
    # If the admin exists AND the password entered is correct.
      @admin = firebase.get("/Admins/"+@admin_id).body
      if @admin["password"] == params[:password]
        session[:admin_id] = @admin_id
        redirect_to '/admins'
      else
      # If admin's login doesn't work, send them back to the login form.
      redirect_to '/admins/login'
      end
    else
      redirect_to '/admins/login'
    end
  end

  def destroy_admin
    reset_session
    @current_admin = nil
    redirect_to '/admins/login'
  end

  def new_user

  end

  def login_user

    @user_id = find_id(firebase.get("/Users").body,"uid",params[:uid])
    unless @user_id == nil
      # If the user exists AND the password entered is correct.
      @user = firebase.get("/Users/"+@user_id).body
      if @user["password"] == params[:password]
        session[:user_id] = @user_id
        redirect_to '/users/home'
      else
        # If user's login doesn't work, send them back to the login form.
        redirect_to '/users/login', :flash => { :notice => "Wrong User ID or Password" }
      end
    else
      redirect_to '/users/login', :flash => { :notice => "Wrong User ID or Password" }
    end
  end

  def destroy_user
    reset_session
    @current_user = nil
    redirect_to '/users/login'
  end
end
