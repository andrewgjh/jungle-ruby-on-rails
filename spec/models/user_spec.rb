require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validation for user' do
    before(:each) do
      user_params = {"name"=>"Tester",
      "email"=>"Tester@testerville.com",
      "password"=>"123456",
      "password_confirmation"=>"123456"}
      @test_user = User.create(user_params)
      @test_user.save
      @total_users = User.all.count
    end
    after(:each) do
      if @test_user 
        @test_user.destroy
      end
      @test_user.destroy
    end

    context 'with password fields ' do

      it 'where password and password_confirmation exist' do 
        user_params = {"name"=>"billy",
        "email"=>"billy@testerville.com",
        "password"=>"123456"}
        @test_user1 = User.create(user_params)
        @test_user1.save
        expect(User.all.count).to eq(@total_users)
      end

      it 'where it does not save when password and password_confirmation do not match' do 
        user_params = {"name"=>"billy",
        "email"=>"billy@testerville.com",
        "password"=>"123456",
        "password_confirmation"=>"1mnn23543"}
        @test_user2 = User.create(user_params)
        @test_user2.save
        expect(User.all.count).to eq(@total_users)
      end

    end

    context "with email field" do
      it "where it does not save when the email is not unique case insensitive" do
        user_params = {"name"=>"Tester",
        "email"=>"TEster@testerville.com",
        "password"=>"123456",
        "password_confirmation"=>"123456"}
        @test_user3 = User.create(user_params)
        @test_user3.save
        expect(User.all.count).to eq(@total_users)
      end
    end

    context 'password' do
      it "should be at least 5 characters" do
        user_params = {"name"=>"Tester",
        "email"=>"jim@testerville.com",
        "password"=>"123",
        "password_confirmation"=>"123"}
        @test_user4 = User.create(user_params)
        @test_user4.save
        expect(User.all.count).to eq(@total_users)
      end
    end

    context ".authenticate_with_credentials" do
    it 'happy path' do
      @test_user5 = User.authenticate_with_credentials("tester@testerville.com", '123456')
      expect(@test_user5[:name]).to eq("Tester")
    end
    it 'wrong password' do
      @test_user6 = User.authenticate_with_credentials("tester@testerville.com", '1234ds56')
      expect(@test_user6).to eq(nil)
    end
    it 'email does not exist' do
      @test_user6 = User.authenticate_with_credentials("faketester@testerville.com", '123456')
      expect(@test_user6).to eq(nil)
    end
    it 'email with extra spaces before' do
      @test_user6 = User.authenticate_with_credentials("   tester@testerville.com", '123456')
      expect(@test_user6.name).to eq("Tester")
    end
    it 'correct email with random Capitalize letters' do
      @test_user6 = User.authenticate_with_credentials("   tesTer@teSterville.com", '123456')
      expect(@test_user6.name).to eq("Tester")
    end
  end
  end
end
