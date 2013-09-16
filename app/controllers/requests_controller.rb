class RequestsController < ApplicationController

  load_and_authorize_resource edit: [:accept, :reject]

  def index
    @requests_proposed = current_user.registrateable.requests_received.with_state(:proposed)
    @requests_sent = current_user.registrateable.requests_sent
  end

  def accept
    @request.accept
    flash[:info] = 'You rejected request'
    redirect_to requests_path
  end

  def reject
    @request.reject
    flash[:info] = 'You accepted request'
    redirect_to requests_path
  end
end
