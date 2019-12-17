require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "is valid with valid attributes" do
      @user = User.new(first_name: "First", last_name: "Last", email: "e@mail.com", password: "password", password_confirmation: "password")
      expect(@user).to be_valid
      expect(@user.errors.full_messages).to be_empty
    end

    it "must be created with a password and password_confirmation fields" do
      @user = User.new(first_name: "First", last_name: "Last", email: "e@mail.com", password: nil, password_confirmation: nil)
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password can't be blank", "Password confirmation can't be blank")

      @user2 = User.new(first_name: "First", last_name: "Last", email: "e@mail.com", password: "abc", password_confirmation: "def")
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "must be created with a unique email" do
      @user = User.create(first_name: "First", last_name: "Last", email: "ABC@DEF.COM", password: "password", password_confirmation: "password")
      expect(@user).to be_valid

      @user2 = User.new(first_name: "First", last_name: "Last", email: "abc@def.com", password: "password", password_confirmation: "password")
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it "must be created with email, first name, last name" do
      @user = User.new(first_name: nil, last_name: nil, email: nil, password: "password", password_confirmation: "password")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("First name can't be blank", "Last name can't be blank", "Email can't be blank")
    end

    it "must be created with password with at least 5 characters" do
      @user = User.new(first_name: "First", last_name: "Last", email: "e@mail.com", password: "1", password_confirmation: "1")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 5 characters)", "Password confirmation is too short (minimum is 5 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    it "must log in with correct credentials" do
      User.create(first_name: "First", last_name: "Last", email: "e@mail.com", password: "12345", password_confirmation: "12345")
      expect(User.authenticate_with_credentials("e@mail.com", "12345")).to be_truthy
    end
    it "must log in with spaces around email" do
      User.create(first_name: "First", last_name: "Last", email: "example@domain.com", password: "12345", password_confirmation: "12345")
      expect(User.authenticate_with_credentials(" example@domain.com ", "12345")).to be_truthy
    end
  end

end
