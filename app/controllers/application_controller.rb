class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :firebase, :find_id, :current_admin, :current_user

  def current_admin
    @current_admin ||= firebase.get("/admins/"+session[:admin_id]).body if session[:admin_id]
  end

  def authorize_admin
    redirect_to '/admins/login' unless current_admin
  end

  def current_user
    @current_user ||= firebase.get("/users/"+session[:user_id]).body if session[:user_id]
  end

  def authorize_user
      redirect_to '/users/login' unless current_user
  end

  def logged_user_or_admin
    if current_user
      redirect_to '/users/home'
    elsif current_admin
      redirect_to '/buses/live'
    end
  end

  def firebase
    base_uri = 'https://o6u-bus-tracker-cf9ed.firebaseio.com/'
    firebase = Firebase::Client.new(base_uri)
  end

  def find_id(table_hash,item_key,item_value)
    table_hash.each do |id_key,id_value|
      id_value.each do |id_value_key, id_value_value|
        if id_value_key == item_key && id_value_value == item_value
          return id_key
        end
      end
    end
    return nil
  end
end
