require "rails_helper"

describe "users/show" do
  it "shows the correct user" do
    user = FactoryGirl.create(:user_with_avatar, name: "George Testman")
    assign(:user, user)

    render

    expect(rendered).to match /George Testman/
    expect(rendered).to have_css "img[src='#{user.avatar.url(:thumb)}']"
  end
end
