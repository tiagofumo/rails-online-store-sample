require "rails_helper"

describe "users/edit_password" do
  it "shows the correct fields" do
    user = FactoryGirl.create(:complete_user)
    assign(:current_user, user)

    render

    expect(rendered).to match /Change Password/
    expect(rendered).to have_css "input[name='user[current_password]']"
    expect(rendered).to have_css "input[name='user[password]']"
    expect(rendered).to have_css "input[name='user[password_confirmation]']"
    expect(rendered).to have_css "input[type='submit'][value='Update Password']"
  end
end
