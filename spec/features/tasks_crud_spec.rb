require 'rails_helper'

feature "CRUD of tasks" do
  given!(:hello_world) { FactoryBot.create(:user_hw) }

  background(:each) do
    login_as(hello_world)
  end

  feature "creating tasks" do

    scenario "Should have a page for creating new tasks" do
      visit new_task_url
      expect(page).to have_content "New Task"
    end

    scenario "should show the new task after creation" do
      submit_new_task("grow a beard")
      expect(page).to have_content "grow a beard"
      expect(page).to have_content "Task Saved!"
    end

  end

  feature "reading tasks" do
    scenario "should have a page for viewing tasks" do
      visit tasks_url
      expect(page).to have_content "All Tasks"
    end

    scenario "Should list tasks" do
      make_three_tasks(hello_world)
      verify_three_tasks
    end
  end

  feature "updating tasks" do
    given(:task) { FactoryBot.create(:task, owner: hello_world) }

    scenario "Should have a page for updating an existing task" do
        visit edit_task_url(task)
        expect(page).to have_content "Edit Task"
        expect(find_field('Title:').value).to eq(task.title)
    end

    scenario "should show the updated task after changes are saved" do
      visit edit_task_url(task)
      fill_in "Title", with: "visit the sun"
      click_button "Update Task"
      expect(page).not_to have_content "Update Task!"
      expect(page).to have_content "visit the sun"
      expect(page).to have_content "Task updated!"
    end

  end

  feature "deleting tasks" do
    scenario "should allow the deletion of a task" do
      make_three_tasks(hello_world)
      visit tasks_url
      click_button "Delete kick the can Task"
      expect(page).not_to have_content "kick the can"
      expect(page).to have_content "Task deleted!"
    end
  end

end
