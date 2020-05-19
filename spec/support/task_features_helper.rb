# When adding this /support dir, and subsequent files, need to make note of them in the rails_helper.rb file so that rspec knows to include them as part of features.

 module TaskFeaturesHelper
   def submit_new_task(task_title, privacy = {private: false} )
     visit new_task_url
     fill_in "Title:", with: task_title
     fill_in "Description:", with: "This is a test description"
     if privacy[:private]
       check "Private?:"
     end
     click_button "Create Task"
   end

   def make_three_tasks(user)
     FactoryBot.create(:task, title: "walk the dog", owner: user)
     FactoryBot.create(:task, title: "kick the can", owner: user)
     FactoryBot.create(:task, title: "go to Mars", owner: user)
   end

   def verify_three_tasks
     visit tasks_url
     expect(page).to have_content "walk the dog"
     expect(page).to have_content "kick the can"
     expect(page).to have_content "go to Mars"
   end

 end
