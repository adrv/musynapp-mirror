class SignUp::RegistrationsController < ApplicationController
  
  load_resource

  def new
    build_secret_questions
  end

  def create
    @registration.registrateable = create_resource( registration_params[:registrateable_type] )
    if @registration.save
      session[:user_id]  = @registration.id
      @user = @registration.registrateable
      redirect_to [:step_one, @user, :registrations ]
    else
      build_secret_questions
      render :new
    end
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
