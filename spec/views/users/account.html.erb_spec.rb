require "rails_helper"

describe "users/account" do
  it "shows the correct fields" do
    user = FactoryGirl.create(:user, :has_account_fields)
    assign(:current_user, user)

    render

    expect(rendered).to match /Account/
    expect(rendered).to have_css "input[name='user[name]']"\
                                 "[value='#{user.name}']"
    expect(rendered).to have_css "input[name='user[company]']"\
                                 "[value='#{user.company}']"
    expect(rendered).to have_css "input[name='user[phone]']"\
                                 "[value='#{user.phone}']"
    expect(rendered).to have_css "input[name='user[fax]'][value='#{user.fax}']"
    expect(rendered).to have_css "input[type='submit'][value='Update']"
  end
end
