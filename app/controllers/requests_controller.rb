class RequestsController < ApplicationController

  load_and_authorize_resource edit: [:accept, :reject]

  def index
    @requests_proposed = current_user.registrateable.requests_received.with_state(:proposed)
    @requests_sent = current_user.registrateable.requests_sent
  end

  def accept
    @request.accept
    flash[:info] = 'You accepted request'
    redirect_to requests_path
  end

  def reject
    @request.reject
    flash[:info] = 'You rejected request'
    redirect_to requests_path
  end

  def manage_selection
    @requests = Request.find(request_params[:request_ids])
    commit = params[:commit]
    if commit.in? %w(accept reject)
      @requests.each { |req| req.send(commit) }
      flash[:info] = "Successfully #{commit}ed" 
    end
    redirect_to requests_path
  end

  def request_params
    params.permit(request_ids: [])
  end
end
