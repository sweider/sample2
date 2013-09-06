# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do
  before { @user = User.new(email: "example@gmail.com",
   name: "Vasya", password: "password", 
   password_confirmation:"password") }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:microposts) }

  it { should be_valid }

  describe " Missing name" do
    before { @user.name = " " }

    it { should_not be_valid }
  end

  describe "Missing email" do
    before { @user.email = " "}

    it { should_not be_valid }
  end

  describe "Blank password" do
    before { @user.password = @user.password_confirmation = " " }

    it { should_not be_valid }
  end

  describe "Wrong password confirmation" do 
    before { @user.password_confirmation = "bla" }

    it {  should_not be_valid }
  end

  describe "Nil password confirmation" do
    before { @user.password_confirmation = nil }

    it { should_not be_valid }
  end

  describe "Very long name" do
    before { @user.name = "a" * 51 }

    it { should_not be_valid }
  end

  describe "Very short name" do 
    before { @user.name = "a" * 2 }

    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end


  describe "Authenticate method values" do 
    before { @user.save }

    let(:found_user) { User.find_by_email(@user.email) }

      describe "Valid password" do
        it{ should == found_user.authenticate(@user.password) }
      end

      describe "Invalid password" do
        let(:user_for_invalid_password) { found_user.authenticate("invalid") }

        it { should_not == user_for_invalid_password }
        specify { user_for_invalid_password.should be_false  } 
      end        
  end


  describe "micropost associatins" do 
    before { @user.save }

    let!(:older_post) { FactoryGirl.create(:micropost,
     user: @user, created_at: 1.day.ago) }

    let!(:newer_post) { FactoryGirl.create(:micropost,
     user: @user, created_at: 1.hour.ago) }

    it "should have microposts in right order" do
      @user.microposts.should == [:newer_post, :older_post ]
    end

  end

end
