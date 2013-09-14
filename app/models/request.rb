class Request < ActiveRecord::Base
  belongs_to :requester, polymorphic: true
  belongs_to :requested, polymorphic: true
  belongs_to :show
end
