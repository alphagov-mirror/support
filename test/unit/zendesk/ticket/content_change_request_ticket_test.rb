require 'test/unit'
require 'shoulda/context'
require 'zendesk/ticket/content_change_request_ticket'
require 'ostruct'

module Zendesk
  module Ticket
    class ContentChangeRequestTicketTest < Test::Unit::TestCase
      def ticket_with(opts)
        ContentChangeRequestTicket.new(stub_everything("request", opts))
      end

      should "contain the title in the subject, if one is provided" do
        assert_equal "Abc - Content change request", ticket_with(title: "Abc").subject
      end

      should "not insist on a title in the subject" do
        assert_equal "Content change request", ticket_with({}).subject
      end

      context "an inside government request" do
        should "be tagged with inside_government" do
          tags_on_ticket = ticket_with(:inside_government_related? => true).tags
          assert_includes tags_on_ticket, "content_amend"
          assert_includes tags_on_ticket, "inside_government"
        end
      end
    end
  end
end