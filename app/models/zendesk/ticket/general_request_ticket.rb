require 'zendesk/zendesk_ticket'
require 'zendesk/labelled_snippet'

module Zendesk
  module Ticket
    class GeneralRequestTicket < ZendeskTicket
      def subject
        if (@request.title.nil? or @request.title.empty?)
          "Govt Agency General Issue"
        else
          "#{@request.title} - Govt Agency General Issue"
        end
      end

      def tags
        super + ["govt_agency_general"]
      end

      protected
      def comment_snippets
        [
          LabelledSnippet.new(on: @request, field: :url),
          LabelledSnippet.new(on: @request, field: :user_agent),
          LabelledSnippet.new(on: @request, field: :details)
        ]
      end
    end
  end
end
