require 'spec_helper'

describe "Instructor pages" do

  subject { page }

  describe "instructor page" do
    let(:instructor) { FactoryGirl.create(:instructor) }
    before(:each) do
      sign_in instructor
      visit instructors_path
    end

    it { should have_title('All instructors') }
    it { should have_content('All instructors') }
    it { should_not have_link('delete') }
    
    describe "pagination" do

      before(:all) { 31.times { FactoryGirl.create(:instructor) } }
      after(:all)  { Instructor.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each instructor" do
        Instructor.paginate(page: 1).each do |instructor|
          expect(page).to have_selector('li', text: instructor.name)
        end
      end
    end

    describe "delete links" do

      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin2) }
        
        before do
          sign_in admin
          visit instructors_path
        end
        

        before(:all) { 31.times { FactoryGirl.create(:instructor) } }
        after(:all)  { Instructor.delete_all }

        it { should have_link('delete', href: instructor_path(Instructor.first)) }
        it "should be able to delete another user" do
          expect do
            click_link('delete', match: :first)
          end.to change(Instructor, :count).by(-1)
        end
        it { should_not have_link('delete', href: instructor_path(admin)) }
      end
    end
  end 


  # test for index page
describe "index" do
  describe "sign in a instructor" do
   let(:instructor) { FactoryGirl.create(:instructor) }
   before(:each) do
     sign_in instructor
   end

   it { should have_link('Instructors', href: instructors_path) }
   it { should have_link('Users', href: users_path) }
   

  end

  describe "sign in a admin" do
    let(:admin) { FactoryGirl.create(:admin2) }
    before(:each) do
     sign_in admin
    end

    it { should have_link('Users', href: users_path) }
    it { should have_link('Instructors', href: instructors_path) }
    
    describe "visit users_path " do
      before do
        visit instructors_path
      end
      it { should have_title('All instructors') }
      it { should have_content('All instructors') }

      describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:instructor) } }
      after(:all)  { Instructor.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        Instructor.paginate(page: 1).each do |instructor|
          expect(page).to have_selector('li', text: instructor.name)
        end 
      end

      describe "admin delete users" do
        before do
          sign_in admin
          visit instructors_path
        end

        it { should have_link('delete', href: instructor_path(Instructor.first)) }
        it "should be able to delete another user" do
          expect do
            click_link('delete', match: :first)
          end.to change(Instructor, :count).by(-1)
        end
        it { should_not have_link('delete', href: instructor_path(admin)) }
      end
    end
   end
  end
end
    


  describe "profile page" do
    let(:instructor) { FactoryGirl.create(:instructor) }
    before { visit instructor_path(instructor) }

    it { should have_content(instructor.name) }
    it { should have_title(instructor.name) }
    it { should have_content(instructor.facility) }
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
