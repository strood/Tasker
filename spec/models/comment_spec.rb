# == Schema Information
#
# Table name: comments
#
#  id             :bigint           not null, primary key
#  content        :text             not null
#  imageable_type :string
#  imageable_id   :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require 'rails_helper'

RSpec.describe Comment, type: :model do
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

  subject(:user) { User.new(username: "Frank", session_token: "123456", password_digest: "aabbccddeeff", password: "good_password") }

  subject(:comment) { Comment.new(imageable_type: "User", imageable_id: user.id, content: "My cool test comment about frank!") }

  describe "validations" do
    it { should validate_presence_of(:content) }
    it { should belong_to(:imageable) }
    
  end


end
