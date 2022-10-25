require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new
    @user.first_name = "John"
    @user.last_name = "Doe"
    @user.email = "john@doe.com"
    @user.password = "password"
    @user.password_confirmation = "password"
  end

  describe 'Validations' do
    it 'should validate presence of all five fields' do
      @user.validate
      expect(@user).to be_valid
    end

    it 'should not validate without matching passwords' do
      @user.password_confirmation = "word"
      @user.validate
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end 

    it 'should not validate if email already exists' do
      @user.save
      #
      @user_fake = User.new
      @user_fake.first_name = "Joseph"
      @user_fake.last_name = "Doe"
      @user_fake.email = "john@DOE.com"
      @user_fake.password = "password"
      @user_fake.password_confirmation = "password"
      @user_fake.validate
      expect(@user_fake.errors.full_messages).to include("Email has already been taken")
    end


    it 'should not validate if email is blank' do
      @user.email = nil
      @user.validate
      expect(@user.errors.full_messages).to include("Email can't be blank")
      end

    it 'should not validate if first name is blank' do
      @user.first_name = nil
      @user.validate
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'should not validate if last name is blank' do
      @user.last_name = nil
      @user.validate
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'should not validate if password length < 8' do
      @user.password = "word"
      @user.password_confirmation = "word"
      @user.validate
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should not authenticate with wrong email' do
      @user.save
      existing_user = User.find_by_email("john@doe.com")
      expect(existing_user.authenticate_with_credentials("catherine@joe.com", "password")).to be_nil
    end

    it 'should not authenticate with wrong password' do
      @user.save
      existing_user = User.find_by_email("john@doe.com")
      expect(existing_user.authenticate_with_credentials("john@joe.com", "word")).to be_nil
    end

    it 'should authenticate with trailing spaces' do
      @user.save
      existing_user = User.find_by_email("john@doe.com")
      expect(existing_user.authenticate_with_credentials("john@doe.com   ", "password")).to_not be_nil
    end
  end
end
