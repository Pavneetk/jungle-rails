require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    
    after :each do
      User.delete(@user)
    end
    
    it 'is valid with all attributes' do
      @user = User.new({
        first_name:  'Ffej',
        last_name: "Sozeb",
        email: "example@email.com",
        password: "Password",
        password_confirmation: "Password"
      })
      @user.save
      expect(@user).to be_valid
    end

    it 'is invalid if missing first name' do
      @user = User.new({
        last_name: "Sozeb",
        email: "example@email.com",
        password: "Password",
        password_confirmation: "Password"
      })
      @user.save
      expect(@user).to be_invalid
      expect(@user.errors.full_messages[0]).to eq("First name can't be blank")
    end

    it 'is invalid if missing last name' do
      @user = User.new({
        first_name:  'Ffej',
        email: "example@email.com",
        password: "Password",
        password_confirmation: "Password"
      })
      @user.save
      expect(@user).to be_invalid
      expect(@user.errors.full_messages[0]).to eq("Last name can't be blank")
    end

    it 'is invalid if missing email' do
      @user = User.new({
        first_name:  'Ffej',
        last_name: "Sozeb",
        password: "Password",
        password_confirmation: "Password"
      })
      @user.save
      expect(@user).to be_invalid
      expect(@user.errors.full_messages[0]).to eq("Email can't be blank")
    end

    it 'is invalid if email already exists' do
      @user1 = User.new({
        first_name:  'Ffej',
        last_name: "Sozeb",
        email: "example@email.com",
        password: "Password",
        password_confirmation: "Password"
      })
      @user1.save
      @user2 = User.new({
        first_name:  'Ffej',
        last_name: "Sozeb",
        email: "example@email.com",
        password: "Password",
        password_confirmation: "Password"
      })
      @user2.save
      expect(@user2).to be_invalid
      expect(@user2.errors.full_messages[0]).to eq("Email has already been taken")
      User.delete(@user1)
      User.delete(@user2)
    end

    it 'is invalid if password does not match password confirmation' do
      @user = User.new({
        first_name:  'Ffej',
        last_name: "Sozeb",
        email: "example@email.com",
        password: "Password",
        password_confirmation: "Passwordasdfsaf"
      })
      @user.save
      expect(@user).to be_invalid
      expect(@user.errors.full_messages[0]).to eq("Password confirmation doesn't match Password")
    end

    it 'is invalid if password does not meet minimum requirements' do
      @user = User.new({
        first_name:  'Ffej',
        last_name: "Sozeb",
        email: "example@email.com",
        password: "Pass",
        password_confirmation: "Pass"
      })
      @user.save
      expect(@user).to be_invalid
      expect(@user.errors.full_messages[0]).to eq("Password is too short (minimum is 5 characters)")
    end
  
  end
  describe '.authenticate_with_credentials' do

    after :each do
      User.delete(@user)
    end
    
    it 'is valid if email and password match a user' do
      @user = User.new({
        first_name:  'Ffej',
        last_name: "Sozeb",
        email: "example@email.com",
        password: "Password",
        password_confirmation: "Password"
      })
      @user.save
      @login = User.authenticate_with_credentials("example@email.com", "Password")
      expect(@login).to eq @user
    end

    it 'is valid if email is in wrong case' do
      @user = User.new({
        first_name:  'Ffej',
        last_name: "Sozeb",
        email: "example@email.com",
        password: "Password",
        password_confirmation: "Password"
      })
      @user.save
      @login = User.authenticate_with_credentials("examPLE@email.cOm", "Password")
      expect(@login).to eq @user
    end

    it 'is valid if email has extra leading or trailing spaces' do
      @user = User.new({
        first_name:  'Ffej',
        last_name: "Sozeb",
        email: "example@email.com",
        password: "Password",
        password_confirmation: "Password"
      })
      @user.save
      @login = User.authenticate_with_credentials("  examPLE@email.cOm  ", "Password")
      expect(@login).to eq @user
    end

    it 'is invalid if email and password do not match a user' do
      @user = User.new({
        first_name:  'Ffej',
        last_name: "Sozeb",
        email: "example@email.com",
        password: "Password",
        password_confirmation: "Password"
      })
      @user.save
      @login = User.authenticate_with_credentials("example@email.com", "Pass")
      expect(@login).to eq nil
    end

  end
end
