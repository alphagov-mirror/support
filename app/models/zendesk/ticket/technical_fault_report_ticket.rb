module Zendesk
  module Ticket
    class TechnicalFaultReportTicket < Zendesk::ZendeskTicket
      def subject
        "Technical fault report"
      end

      def tags
        super + ["technical_fault", fault_context_tag] + inside_government_tag_if_needed
      end

    protected

      def fault_context_tag
        "fault_with_#{@request.fault_context.id}"
      end

      def comment_snippets
        [
          Zendesk::LabelledSnippet.new(
            on: @request.fault_context,
            field: :name,
            label: "Location of fault",
          ),
          Zendesk::LabelledSnippet.new(
            on: @request,
            field: :fault_specifics,
            label: "What is broken",
          ),
          Zendesk::LabelledSnippet.new(on: @request,               field: :actions_leading_to_problem),
          Zendesk::LabelledSnippet.new(on: @request,               field: :what_happened),
          Zendesk::LabelledSnippet.new(on: @request,               field: :what_should_have_happened),
        ]
      end
    end
  end
end
