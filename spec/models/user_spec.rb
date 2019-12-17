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
    end
  end
end
