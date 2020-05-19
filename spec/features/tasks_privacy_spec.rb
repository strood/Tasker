require 'rails_helper'

feature "task privacy" do
  given!(:hello_world) { FactoryBot.create(:user_hw) }
  given!(:foo_bar) { FactoryBot.create(:user_foo) }

  describe "public tasks"  do
    given!(:hw_task) { FactoryBot.create(:task, owner: hello_world) }

    scenario "tasks should be made public by default" do
      login_as(hello_world)
      submit_new_task("lay an egg")
      expect(page).to have_content "Public"
    end

    scenario "shows public tasks when logged out" do
      visit user_url(hello_world)
      expect(page).to have_content hw_task.title
    end

    scenario "allow other users to see public tasks" do
      login_as(foo_bar)
      visit user_url(hello_world)
      expect(page).to have_content hw_task.title
    end
  end

  describe "private tasks" do
    given!(:private_task) { FactoryBot.create(:hw_task, private: true) }
    given!(:private_task) do
      FactoryBot.create(:task, owner: hello_world, private: true)
    end

    scenario "allows creating a private task" do
      login_as(hello_world)
      visit task_url(private_task)
      expect(page).to have_content "Private"
    end

    scenario "hides private tasks when logged out" do
      visit user_url(hello_world)
      expect(page).not_to have_content private_task.title
    end

    scenario "keeps private tasks hidden from other users" do
      login_as(foo_bar)
      visit user_url(hello_world)
      expect(page).not_to have_content private_task.title
    end
  end
end
