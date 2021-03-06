require "rails_helper"

feature "New Content Publisher feedback requests" do
  let(:user) { create(:content_requester, name: "John Smith", email: "john.smith@agency.gov.uk") }

  background do
    login_as user
    zendesk_has_no_user_with_email(user.email)
  end

  scenario "successful request" do
    request = expect_zendesk_to_receive_ticket(
      "subject" => "Content Publisher feedback request",
      "requester" => hash_including("name" => "John Smith", "email" => "john.smith@agency.gov.uk"),
      "tags" => %w[govt_form content_publisher_feedback_request],
      "comment" => {
        "body" =>
"[Your feedback is about]
accessibility or usability

[Tell us a bit more]
I am having trouble reading the screen

[What's the impact on your work if we don't do anything about it?]
Cannot work",
      },
    )

    user_provides_feedback(
      feedback_type: "accessibility or usability",
      description: "I am having trouble reading the screen",
      impact_on_work: "Cannot work",
    )

    expect(request).to have_been_made
  end

private

  def user_provides_feedback(details)
    visit "/"
    click_on "Give feedback on Content Publisher (Beta)"
    expect(page).to have_content("Give feedback on Content Publisher (Beta)")
    within "#feedback-type" do
      choose "accessibility or usability"
    end
    fill_in "Tell us a bit more", with: details[:description]
    fill_in "What's the impact on your work if we don't do anything about it?", with: details[:impact_on_work]
    user_submits_the_request_successfully
  end
end
