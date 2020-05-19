require 'rails_helper'

feature "task completeness tracking" do
  given!(:hello_world) { FactoryBot.create(:user_hw) }
  given!(:foo_bar) { FactoryBot.create(:user_foo) }
  given!(:hw_task) { FactoryBot.create(:task, owner: hello_world) }

  background(:each) do
    login_as(hello_world)
  end

  describe "tasks start out uncompleted" do
    context "on the task show page" do
        scenario "starts out as not completed" do
          visit task_url(hw_task)
          expect(page).to have_content("Ongoing")
        end
    end

    context "on the task index page" do
      scenario "starts as not completed" do
        visit tasks_url
        expect(page).to have_content("Ongoing")
      end
    end

    context "on the user's profile page" do
      scenario "starts as not completed" do
        visit user_url(hello_world)
        expect(page).to have_content("Ongoing")
      end
    end

  end

  describe "marking the tasks as completed" do
    context "on the task show page" do
      scenario "allows user to change task to completed" do
        visit task_url(hw_task)
        click_button "Completed"
        expect(page).to have_content("Complete")
      end

      scenario "redirects to the same page after updating task" do
        visit task_url(hw_task)
        click_button "Completed"
        expect(page).to have_content("Task Title:")
        expect(page).to have_content("Title")
        expect(page).to have_content(hw_task.title)
      end

      scenario "disallows editing completeness when it is not your task" do
        click_button "Sign Out"
        login_as(foo_bar)
        visit task_url(hw_task)
        expect(page).not_to have_content("Complete")
      end

    end

    context "on the task index page" do
      scenario "allows user to change task to completed" do
        visit tasks_url
        click_button "Completed"
        expect(page).to have_content("Complete")
      end

      scenario "redirects to the same page after updating task" do
        visit tasks_url
        click_button "Completed"
        expect(page).to have_content("All Tasks")
      end
    end

    context "on the users profile page" do
      scenario "allows user to change task to completed" do
        visit user_url(hello_world)
        click_button "Completed"
        expect(page).to have_content("Complete")
      end

      scenario "redirects to the same page after updating task" do
        visit user_url(hello_world)
        click_button "Completed"
        expect(page).to have_content("Complete")
        expect(page).to have_content("Hello, hello_world")
        expect(page).to have_content("Your Tasks:")
      end

      scenario "disallows editing completeness when it is not your task" do
        click_button "Sign Out"
        login_as(foo_bar)
        visit user_url(hello_world)
        expect(page).not_to have_button("Complete")
      end
    end

  end

end
