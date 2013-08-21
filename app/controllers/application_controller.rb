class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Acces denied! #{exception}"
    redirect_to user_path current_user
  end

  #Workaround for cancan 1.6.10 with rails4
  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end
  #end workaround


  protected

  def create_resource type
    type.camelize.constantize.create
  end

  def current_user
    @current_user ||= Registration.find(session[:user_id]) if session[:user_id]
  end

end
