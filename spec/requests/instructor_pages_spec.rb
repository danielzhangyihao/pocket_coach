require 'spec_helper'

describe "Instructor pages" do

  subject { page }

  describe "profile page" do
    let(:instructor) { FactoryGirl.create(:instructor) }
    before { visit instructor_path(instructor) }

    it { should have_content(instructor.name) }
    it { should have_title(instructor.name) }
  end

  describe "signup page" do
    before { visit instructorsignup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

  describe "signup" do

    before { visit instructorsignup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(Instructor, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
        fill_in "Name of Business/facility", with:"MMB"
        choose("instructor_companyadmin_true")
      end

      it "should create a instructor" do
        expect { click_button submit }.to change(Instructor, :count).by(1)
      end


    end


    describe "with valid information" do
      before do
        choose("instructor_companyadmin_false")

        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
        select( 'Mare', :from => :facility)
        
        
      end

      it "should create a instructor" do
        expect { click_button submit }.to change(Instructor, :count).by(1)
        
      end


    end
  end
end
