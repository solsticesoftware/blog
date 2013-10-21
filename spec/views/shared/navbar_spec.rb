require 'spec_helper'

describe "shared/_navbar" do

  describe "nav changes based on current action" do
    it "should be 'active' when on application#about_path" do
      params[:action] = "about_page"
      render
      rendered.should have_css "li.active a[href='#{root_path}']"
    end

    it "should be 'active' when on posts#index" do
      params[:action] = "index"
      render
      rendered.should have_css "li.active a[href='#{posts_path}']"
    end

    it "should be 'active' when on application#contact_path" do
      params[:action] = "contact_page"
      render
      rendered.should have_css "li.active a[href='#{contact_path}']"
    end
  end

  describe "all users" do
    before(:each) do
      render
    end

    it "should have the Grndz logo that links to the home page" do
      rendered.should have_css "a[href='/']"
      rendered.should have_css "span.glyphicon.glyphicon-leaf"
    end

    it "should have a link to 'Home'" do
      rendered.should have_css "a[href='/']"
      rendered.should have_content "Home"
    end

    it "should have a link to 'Blog'" do
      rendered.should have_css "a[href='#{posts_path}']"
      rendered.should have_content "Blog"
    end

    it "should have a link to create a 'Contact'" do
      rendered.should have_css "a[href='#{contact_path}']"
      rendered.should have_content "Contact"
    end
  end

  describe "signed in as an admin" do
    before(:each) do
      sign_in FactoryGirl.create(:admin)
      render
    end

    it "should have a link to create a create a 'New Post'" do
      rendered.should have_css "a[href='#{new_post_path}']"
      rendered.should have_content "New Post"
    end

    it "should have a link to the admin's settings page" do
      rendered.should have_css "a[href='/admins/edit']"
      rendered.should have_content "Account"
    end

    it "should have a link to sign the user out" do
      rendered.should have_css "a[data-method='delete']"
      rendered.should have_css "a[href='/admins/sign_out']"
      rendered.should have_content "Sign Out"
    end
  end
end