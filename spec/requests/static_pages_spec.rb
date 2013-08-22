require 'spec_helper'

describe "StaticPages" do

  subject { page }

  let (:base_title) {"Sample App"}

  describe "Home Page" do
    before { visit root_path }

    it { should have_selector('h1',text: 'Sample App') }

    it { should have_selector('title',
     text: "#{base_title} | Home") }

  end

  describe "Help Page" do
    before { visit help_path }

    it { should have_selector('h1', text: 'Help') }

    it { should have_selector('title',
        text: "#{base_title} | Help") }

  end

  describe "About Page" do 
    before { visit about_path }

    it { should have_selector('h1', text: 'About Us') }

    it { should have_selector('title', 
        text: "#{base_title} | About Us") }
  end

  describe "Contact Page" do
    before { visit contact_path }

    it { should have_selector('h1', text: "Contact") }

    it { should have_selector('title', 
        text: "#{base_title} | Contact") }
  end
end
