require 'spec_helper'
require 'rails_helper'


feature 'the signup process' do

  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content("Create User")
    expect(page).to have_current_path(new_user_url)
  end

  feature 'signing up a user' do

    scenario 'shows username on the homepage after signup' do
      sign_up_as("Cool Username")
      expect(page).to have_content("Cool Username")
    end


  end

end


feature 'logging in' do
  given!(:hello_world) { FactoryBot.create(:user_hw) }

  scenario 'shows usename on the homepage after login' do
    login_as(hello_world)
    expect(page).to have_content "hello_world"
  end
end


feature 'logging out' do
  given!(:hello_world) { FactoryBot.create(:user_hw) }

  scenario 'begins with a logged out state' do
    visit root_url
    expect(page).to have_content "Log In"
  end

  # COuldnt get to work, diabling
  scenario 'doesn\'t show username on the homepage after logout' do
    login_as(hello_world)
    click_button 'Sign Out'
    expect(page).not_to have_content "Hello, hello_world"
  end

end
