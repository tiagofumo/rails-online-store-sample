require "rails_helper"

describe "users/profile" do
  it "shows the correct fields" do
    user = FactoryGirl.create(:user_with_avatar, :has_profile_fields)
    assign(:current_user, user)
    render
    expect(rendered).to match /Profile/
    expect(rendered).to have_css "input[name='user[alias]']"\
                                 "[value='#{user.alias}']"
    expect(rendered).to have_css "select[name='user[country]']>option"\
      "[value='#{user.country}'][selected='selected']"
    expect(rendered).to have_css "textarea[name='user[profile]']",
                                 text: user.profile
    expect(rendered).to have_css "input[type='file'][name='user[avatar]']"
    expect(rendered).to have_css "img.user-profile__picture"\
                                  "[src='#{user.avatar.url(:medium)}']"
    expect(rendered).to have_css "input[type='submit'][value='Update']"
  end
end
