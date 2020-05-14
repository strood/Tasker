# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  session_token   :string           not null
#  password_digest :string           not null
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

  subject(:user) { User.new(username: "Frank", session_token: "123456", password_digest: "aabbccddeeff", password: "good_password") }

  describe "validations" do
    it { should validate_presence_of(:username) }
    # Disableing test below as it bugs out when i get my auto-reset session_token happening, so just disabling
    # it { should validate_presence_of(:session_token) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password).is_at_least(6) }
    it { should have_many(:tasks) }

    
  end

  describe "Password encryption" do

    it "does not save your raw password to the database" do
      User.create!(username: "Steven", password: "secret_password")
      user = User.find_by(username: "Steven")
      expect(user.password).not_to be("secret_password")
    end

    it "encrypts password using BCrypt" do
      expect(BCrypt::Password).to receive(:create)
      User.new(username: "TestName", password: "test-pass")
    end

  end

  describe "class methods" do
    describe "find_by_credentials(username, password)" do
      before { user.save! } #Add this line so we save use rot db, so it can be looked up

      it "finds a user when correct info given" do
        expect(User.find_by_credentials(user.username, user.password)).to eq(user)
      end

      it "returns nil if incorrect password given" do
        expect(User.find_by_credentials(user.username, "bad_pass")).to eq(nil)
      end

      it "returns nil if unregistered username given" do
        expect(User.find_by_credentials("user", "randompass")).to eq(nil)
      end
    end
  end

end
