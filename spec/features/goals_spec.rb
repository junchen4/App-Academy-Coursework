require 'spec_helper'
require 'rails_helper'


feature 'goals CRUD' do
  before(:each) do
    create_user('testuser')
  end

  it 'allows user to create a goal' do
    visit new_goal_url
    fill_in 'goal', with: 'ride a bike'
    choose 'Public'
    click_button 'Create Goal'
  end

  it 'lets user see their goals' do
    create_goal
    expect(page).to have_content 'ride a bike'
  end

  it 'lets user update a goal' do
    create_goal
    click_link 'Edit Goal'
    fill_in 'goal', with: 'drive a car'
    click_button 'Update Goal'
    expect(page).to have_content 'drive a car'
  end

  it 'lets user delete a goal' do
    create_goal
    click_button 'Delete'
    expect(page).not_to have_content 'ride a bike'
  end
end

feature 'private/public goals' do
  before(:each) do
    create_user('dave')
    create_user('steve')
  end

  it 'does not let users see private goals of others' do
    login_user('dave')
    create_goal
    click_button 'Logout'
    login_user('steve')
    expect(page).not_to have_content 'ride a bike'
  end

  it 'lets users see all public goals' do
    login_user('dave')
    create_public_goal
    click_button 'Logout'
    login_user('steve')
    expect(page).to have_content 'drive a car'
  end

  it 'lets user mark goals as completed' do
    create_goal
    click_button 'Mark as Completed'
  end

  it 'shows that goals have been completed' do
    create_goal
    click_button 'Mark as Completed'
    expect(page).to have_content('Completed')
  end

end
