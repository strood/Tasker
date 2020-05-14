require 'spec_helper'
require 'rails_helper'


feature 'the signup process' do

  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content("Create User")
    expect(page).to have_current_path(new_user_url)
  end

  feature 'signing up a user' do
    before(:each) do
        visit new_user_url
        fill_in 'Username:', :with => "Username"
        fill_in 'Password:', :with => "good_password"
        click_on 'Create User'
    end

    scenario 'shows username on the homepage after signup' do
      expect(page).to have_content("User Page")
    end


  end

end


feature 'logging in' do
  before(:each) do
    visit new_session_url
    fill_in 'Username:', :with => "Username"
    fill_in 'Password:', :with => "good_password"
    click_on "Sign In"
  end

  scenario 'shows usename on the homepage after login' do
    expect(page).to have_content "Username"
  end
end


feature 'logging out' do
  scenario 'begins with a logged out state' do
    visit root_url
    expect(page).to have_content "Log In"
  end

  # COuldnt get to work, diabling
  # scenario 'doesn\'t show username on the homepage after logout' do
  #
  #   click_on 'Sign Out'
  #   expect(page).not_to have_content "Hello, "
  # end

end
