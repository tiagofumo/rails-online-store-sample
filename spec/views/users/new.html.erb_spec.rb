require "rails_helper"

describe "users/new" do
  it "shows the registration form" do
    assign(:user, User.new())

    render

    expect(rendered).to match /Register/
    expect(rendered).to have_css "label", text: 'Name'
    expect(rendered).to have_css "input[name='user[name]']"
    expect(rendered).to have_css "label", text: 'Email'
    expect(rendered).to have_css "input[name='user[email]']"
    expect(rendered).to have_css "label", text: 'Password'
    expect(rendered).to have_css "input[name='user[password]']"
    expect(rendered).to have_css "label", text: 'Password confirmation'
    expect(rendered).to have_css "input[name='user[password_confirmation]']"
    expect(rendered).to have_css "input[type='submit'][value='Register']"
  end
end
