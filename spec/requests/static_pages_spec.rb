require 'spec_helper'

describe "StaticPages" do
  describe "Home Page" do
    it "should have the right content 'Sample App' " do 
      visit '/static_pages/home'
      page.should have_selector('h1', 
        text: 'Sample App')
    end

    it "should have the title 'Home'" do
      visit '/static_pages/home'
      page.should have_selector('title',
        text: "Sample App | Home")
    end
  end

  describe "Help Page" do
    it "should have the right cintent 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('h1', text: 'Help')
    end

    it "should have yhe title 'Help'" do 
      visit "/static_pages/help"
      page.should have_selector('title',
        text: "Sample App | Help")
    end
  end

  describe "About Page" do 
    it "should have the right content 'About Us'" do
      visit '/static_pages/about'
      page.should have_selector('h1', text: 'About Us')
    end

    it "should have right title" do 
      visit "/static_pages/about"
      page.should have_selector('title', 
        text: "Sample App | About")
    end
  end
end
