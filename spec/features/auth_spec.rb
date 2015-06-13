require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New User"
  end

  feature "signing up a user" do

    it "shows username on the homepage after signup" do
      visit new_user_url
      fill_in 'username', :with => 'testname'
      fill_in 'password', :with => 'mypassword'
      click_on 'Create User'
      expect(page).to have_content "testname"
    end
  end

end

feature "logging in" do

  it "shows username on the homepage after login" do
    create_user
    login_user
    expect(page).to have_content "testname"
  end

end

feature "logging out" do

  it "begins with logged out state"


  it "doesn't show username on the homepage after logout" do
    create_user
    login_user
    click_on 'Logout'
    expect(page).not_to have_content "testname"
  end

end
