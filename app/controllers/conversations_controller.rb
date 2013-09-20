class ConversationsController < ApplicationController
  load_resource edit: :send_message

  def index
    @conversations = current_user.registrateable.mailbox.conversations.order('created_at DESC')
  end

  def show
  end

  def create
    current_user.registrateable.send_message find_recipient, params[:message][:body], params[:message][:subject]
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
