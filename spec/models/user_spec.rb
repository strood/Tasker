# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string
#  session_token   :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
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

  subject(:user) { User.new(username: "Frank", session_token: "123456", password_digest: "aabbccddeeff", password: "good_password" ) }

  describe "validations" do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:session_token) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password) }

  end

  describe "class methods" do
    describe "find_by_credentials(username, password)" do
      before { user.save! } #Add this line so we save use rot db, so it can be looked up

      it "finds a user when correct info given" do
        expect(User.find_by_credentials(user.email, user.password)).to eq(user)
      end

      it "returns nil if incorrect password given" do
        expect(User.find_by_credentials(user.email)).to eq(nil)
      end

      it "returns nil if unregistered email given" do
        expect(User.find_by_credentials("random@email.com", "randompass")).to eq(nil)
      end
    end
  end

end
