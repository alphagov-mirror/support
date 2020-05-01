module Zendesk
  module Ticket
    class FindCoronavirusSupportTicket < Zendesk::ZendeskTicket
      def subject
        "Placeholder subject"
      end

      def tags
        super << "find_coronavirus_support"
      end

    private

      def comment_snippets
        fields.map do |field|
          Zendesk::LabelledSnippet.new(on: @request, field: field)
        end
      end

      def fields
        %w[placeholder_one placeholder_two]
      end
    end
  end
end
