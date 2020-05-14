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

    end


  end

end


feature 'logging in' do
  scenario 'shows usename on the homepage after login' do

  end
end


feature 'logging out' do
  scenario 'begins with a logged out state' do

  end

  scenario 'doesn\'t show username on the homepage after logout' do

  end

end
