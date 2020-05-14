# When adding this /support dir, and subsequent files, need to make note of them in the rails_helper.rb file so that rspec knows to include them as part of features.
module AuthFeaturesHelper
  def sign_up_as(username)
    visit new_user_url
    fill_in "Username:", with: username
    fill_in "Password:", with: "password"
    click_button "Create User"
  end

  def login_as(user)
    visit new_session_url
    fill_in "Username:", with: user.username
    fill_in "Password:", with: "password"
    click_on "Log In"
  end
end
