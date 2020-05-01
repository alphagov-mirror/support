require "active_support/core_ext"

module Support
  module Requests
    class FindCoronavirusSupportRequest < Request
      attr_accessor :placeholder_one, :placeholder_two

      def self.label
        "Request Changes to Find Coronavirus Support Form"
      end

      def self.description
        "Give feedback or make requests for changes to the Find Coronavirus Support Form"
      end
    end
  end
end
