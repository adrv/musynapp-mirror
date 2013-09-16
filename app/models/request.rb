class Request < ActiveRecord::Base
  belongs_to :requester, polymorphic: true
  belongs_to :requested, polymorphic: true
  belongs_to :show

  state_machine :state, initial: :proposed do

    after_transition on: :accept do |request|
      request.show.update_attribute 'approved', true
    end

    event :accept do
      transition proposed: :accepted
    end

    event :reject do
      transition proposed: :rejected
    end
  end

end
