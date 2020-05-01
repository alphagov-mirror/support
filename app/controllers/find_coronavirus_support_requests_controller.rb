class FindCoronavirusSupportRequestsController < RequestsController
protected

  def new_request
    @find_coronavirus_support_request = Support::Requests::FindCoronavirusSupportRequest.new
  end

  def zendesk_ticket_class
    Zendesk::Ticket::FindCoronavirusSupportTicket
  end

  def parse_request_from_params
    Support::Requests::FindCoronavirusSupportRequest.new(find_coronavirus_support_params)
  end

  def find_coronavirus_support_params
    params.require(:support_requests_find_coronavirus_support_request)
          .permit(
            :placeholder_one,
            :placeholder_two
          )
          .to_h
  end
end
