require 'spec_helper'

describe "UserPages" do
 
 subject { page }
 
 describe "Sign Up Page" do
  before { visit sign_up_path }

  it { should have_selector('title',
   text: "Sample App | Sign Up") }

  it { should have_selector('h1', text: "Sign Up") }
 end
end
