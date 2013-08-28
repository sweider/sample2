require 'spec_helper'

describe "AuthentificationPages" do
  subject { page }

  describe "Sign in page" do
    before { visit sign_in_path }

    it { should have_selector('h1', text: "Sign In") }
    it { should have_selector('title', text: "Sample App | Sign In") }

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      it { should have_selector('title', text: user.name) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Sign out', href: sign_out_path) }
      it { should_not have_link('Sign in', href: sign_in_path) }
      it { should have_link('Settings', href: edit_user_path(user)) }
    end
  end
end
