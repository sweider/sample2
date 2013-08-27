require 'spec_helper'

describe "UserPages" do
 
 subject { page }
 
  describe "Sign Up Page" do
    before { visit sign_up_path }

    it { should have_selector('title',
      text: "Sample App | Sign Up") }

    it { should have_selector('h1', text: "Sign Up") }
  end

  describe "Profile Page" do

    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user)}

    it { should have_selector('title', text: "Sample App | #{user.name}") }
    it { should have_selector('h1', text: user.name) }


  end


  describe "signup" do

    before { visit sign_up_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
end
