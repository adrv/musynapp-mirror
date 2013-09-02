class ApplicationController < ActionController::Base

  helper_method :current_user

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Acces denied! #{exception}"
    redirect_to root_url
  end

  #Workaround for cancan 1.6.10 with rails4
  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end
  #end workaround

  def current_user
    @current_user ||= Registration.find(session[:user_id]) if session[:user_id]
  end

  protected

  def create_resource type
    type.camelize.constantize.create
  end

  def proceed_registration
    if current_user.pending?
      controller = current_user.registrateable_type.downcase.pluralize
      action = current_user.advance_registration || 'show'
      puts controller, action
      redirect_to controller: controller, action: action
    end
  end

  def proceed_registration_or_redirect_to path
    proceed_registration || redirect_to(@band)
  end
end
