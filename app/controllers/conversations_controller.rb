class ConversationsController < ApplicationController
  load_resource edit: :send_message

  def index
    @conversations = current_user.registrateable.mailbox.conversations.order('created_at DESC')
  end

  def show
  end

  def create
    puts '11112121212'
    subject = params[:message][:subject].present? ? params[:message][:subject] : '<No subject>'
    current_user.registrateable.send_message( find_recipient, params[:message][:body], subject )
    flash[:notice] = 'Your message is sent'
    redirect_to find_recipient
  end

  def send_message
    current_user.registrateable.reply_to_conversation find_conversation, params[:message][:body]
    redirect_to :back
  end

  def destroy
  end

  private

  def find_recipient
    reciepent = params[:recipient_type].camelize.constantize.find(params[:recipient_id])
  end

  def find_conversation
    Conversation.find(params[:id])
  end
end
