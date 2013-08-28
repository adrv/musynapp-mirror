class RegistrationsController < ApplicationController
  
  load_and_authorize_resource

  def new
    build_secret_questions
  end

  def create
    @registration.registrateable = create_resource( registration_params[:registrateable_type] )
    if @registration.save
      session[:user_id]  = @registration.id
      @user = @registration.registrateable
      redirect_to polymorphic_url([:edit, @user])
    else
      build_secret_questions
      render :new
    end
  end

  def login_form

  end

  def login
    user = Registration.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Successfully logged in..."
      redirect_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "Successfully logged out."
    redirect_to root_path
  end
  

  private

   def registration_params
     params.require(:registration).permit(:username,
                                           :password,
                                            :password_confirmation,
                                             :registrateable_type,
                                              :dob,
                                               secret_question_answers_attributes: [ :secret_question_id, :body] )
   end

   def build_secret_questions
     2.times { @registration.secret_question_answers.new }
   end

end
