require 'rails_helper'

feature "commenting" do

  given!(:hello_world) { FactoryBot.create(:user_hw) }
  given!(:foo_bar) { FactoryBot.create(:user, username: "foo_bar") }
  given!(:foo_task) { FactoryBot.create(:task, owner: foo_bar) }

  background(:each) do
    login_as(hello_world)
    visit user_url(foo_bar)
  end

  #Using shared examples here like in solution so i have reference for later
  #This is a way we can DRY up out testing code

  shared_examples "comment" do
    scenario "should have a form for adding a new comment" do
      expect(page).to have_content "Comment"
      expect(page).to have_field "comment"
    end

    scenario "Should save the comment when a user submits one" do
      fill_in "Comment", with: "My dapper looking comment for testing!"
      click_on "Add Comment"
      expect(page).to have_content "My dapper looking comment for testing!"
    end
  end

  feature "user profile comment" do
    it_behaves_like "comment"
  end

  feature "task comment" do
    background(:each) do
      click_on foo_task.title
    end

    it_behaves_like "comment"
  end

end
