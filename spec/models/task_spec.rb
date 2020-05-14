# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  user_id     :bigint           not null
#  title       :string           not null
#  description :text             not null
#  private     :boolean          default(FALSE)
#  completed   :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Task, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  # What to test?
  #   Validations
  #   Associations
  #   Class Methods
  #   Error Messages

  # Subject to be used for testing, helps certian validations pass
  # as they need something in the db to compare to, so this fake item serves
  # that purpose

  # Could also use factory bot:
  # subject(:user) do
  #      FactoryBot.build(:user,
  #        email: "jonathan@fakesite.com",
  #        password: "good_password")
  #    end

# subject(:user) { User.new(username: "Frank", session_token: "123456", password_digest: "aabbccddeeff", password: "good_password") }

  # We will keep it simple here and just focus on practicing tests

  subject(:user) { User.new(username: "Frank", session_token: "123456", password_digest: "aabbccddeeff", password: "good_password") }

  subject(:user_2) { User.new(username: "Abby", session_token: "654321", password_digest: "ffeeddccbbaa", password: "good_password") }

  subject(:task) { Task.new(title: "First Assignment", user_id: user.id, description: "A harrowing mission, should you choose to accept it!")}

  subject(:task_c) { Task.new(title: "First Assignment", user_id: user.id, description: "A harrowing mission, should you choose to accept it!", completed: true)}

  subject(:task_i) { Task.new(title: "First Assignment", user_id: user_2.id, description: "A harrowing mission, should you choose to accept it!")}

  describe "validations" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
  end

  describe "class_methods" do
    describe "find_by_user_id(user_id)" do
      before{ user.save!
              task.save! }

      it "finds tasks if given valid info" do
        expect(Task.find_by_user_id(user.id)).to eq(task)
      end

      it "returns nil if unregisterd username given" do
        expect(Task.find_by_user_id(5)).to eq(nil)
      end
    end
  end

end
