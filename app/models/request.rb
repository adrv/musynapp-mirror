class Request < ActiveRecord::Base
  belongs_to :requester, polymorphic: true
  belongs_to :requested, polymorphic: true
  belongs_to :show
  belongs_to :show_address, class_name: 'Show'

  state_machine :state, initial: :proposed do

    after_transition on: :accept do |request|
      if request.show
        request.show.update_attribute 'approved', true
      elsif request.show_address
        request.show_address.fans << request.requester
      end
    end

    event :accept do
      transition proposed: :accepted
    end

    event :reject do
      transition proposed: :rejected
    end
  end

end
