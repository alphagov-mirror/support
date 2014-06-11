require 'spec_helper'
require 'support/requests/remove_user_request'

module Support
  module Requests
    describe RemoveUserRequest do
      it { should validate_presence_of(:requester) }
      it { should validate_presence_of(:user_name) }
      it { should validate_presence_of(:user_email) }

      it { should allow_value("ab@c.com").for(:user_email) }
      it { should_not allow_value("ab").for(:user_email) }

      it { should allow_value("was fired").for(:reason_for_removal) }

      it "allows time constraints" do
        request = RemoveUserRequest.new(time_constraint: double("time constraint", valid?: true)).
          tap(&:valid?)

        expect(request.time_constraint).to_not be_nil
        expect(request.errors[:time_constraint]).to be_empty
      end
    end
  end
end
