require 'spec_helper'
require 'rails_helper'

feature 'goal comments' do
  before(:each) do
    create_user("bob")
    create_public_goal
    create_user("fred")
  end

  it 'lets users leave comments on a goal' do
    visit goal_url(Goal.first)
    fill_in 'Comment', with: "excellent goal!"
    click_button 'Leave Comment'
  end

  it 'show comments that have been left on a goal' do
    visit goal_url(Goal.first)
    leave_comment
    expect(page).to have_content("excellent goal!")
  end

  it 'shows comments to other users' do
    login_user('bob')
    visit goal_url(Goal.first)
    leave_comment
    click_button 'Logout'
    login_user('fred')
    visit goal_url(Goal.first)
    expect(page).to have_content("excellent goal!")
  end

end

feature 'user comments' do
  before(:each) do
    create_user("bob")
    create_public_goal
    create_user("fred")
  end

  it 'lets users leave comments for other users' do
    visit user_url(User.first)
    leave_comment
  end

  it 'show comments that have been left on a user' do
    visit user_url(User.first)
    leave_comment
    expect(page).to have_content("excellent goal!")
  end

  it 'shows comments to other users' do
    login_user('bob')
    visit user_url(User.first)
    leave_comment
    click_button 'Logout'
    login_user('fred')
    visit user_url(User.first)
    expect(page).to have_content("excellent goal!")
  end

end
