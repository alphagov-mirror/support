require "rails_helper"

feature "Find Coronavirus support requests" do
  # In order to request changes to the /find-coronavirus-support form
  # As a government user
  # I want to contact the GOV.UK Support team

  let(:user) { create(:user, name: "John Smith", email: "john.smith@agency.gov.uk") }

  background do
    login_as user
    zendesk_has_no_user_with_email(user.email)
  end

  scenario "successful request" do

    request = expect_zendesk_to_receive_ticket(
      "subject" => "Placeholder subject",
      "requester" => hash_including("name" => "John Smith", "email" => "john.smith@agency.gov.uk"),
      "tags" => %w[govt_form find_coronavirus_support],
      "comment" => {
        "body" =>
"[Placeholder one]
We would like to add a new page

[Placeholder two]
We would like it added by Friday"
    },
    )

    user_makes_a_find_coronavirus_support_request(
      placeholder_one: "We would like to add a new page",
      placeholder_two: "We would like it added by Friday",
    )

    expect(request).to have_been_made
  end

private

  def user_makes_a_find_coronavirus_support_request(details)
    visit "/"

    click_on "Request Changes to Find Coronavirus Support Form"

    expect(page).to have_content("Please use this path to request changes to the /find-coronavirus-support form")

    fill_in "Details", with: details[:placeholder_one]
    fill_in "More details", with: details[:placeholder_two]

    user_submits_the_request_successfully
  end
end
