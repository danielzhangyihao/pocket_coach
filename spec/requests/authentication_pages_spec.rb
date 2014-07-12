require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_content('Sign in') }
    it { should have_title('Sign in') }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_title('Sign in') }
      it { should have_selector('div.alert.alert-error') }

      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end


    describe "user with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }

      it { should have_title(user.name) }
      it { should have_link('Users',     href: users_path) }
      it { should have_link('Profile',     href: user_path(user)) }
      it { should have_link('Settings',    href: edit_user_path(user)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
      it { should_not have_link('Settings',     href: edit_instructor_path(user) ) }
    
      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
    end


    describe "with valid information" do
      let(:instructor) { FactoryGirl.create(:instructor) }
      before do
        fill_in "Email",    with: instructor.email.upcase
        fill_in "Password", with: instructor.password
        click_button "Sign in"
      end

      it { should have_title(instructor.name) }
      it { should have_link('Profile',     href: instructor_path(instructor)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
      it { should have_link('Settings',     href: edit_instructor_path(instructor) ) }
      it { should_not have_link('Settings',     href: edit_user_path(instructor) ) }

    end


  end


  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      let(:instructor) { FactoryGirl.create(:instructor) }

       describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            expect(page).to have_title('Edit user')
          end
        end
      end

      describe "in the Users controller" do

        describe "visiting the student edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('Sign in') }
        end

        describe "visiting the instructor edit page" do
          before { visit edit_instructor_path(instructor) }
          it { should have_title('Sign in') }
        end

        describe "submitting to the student update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "submitting to the instructor update action" do
          before { patch instructor_path(instructor) }
          specify { expect(response).to redirect_to(signin_path) }
        end



        describe "visiting the user index" do
          before { visit users_path }
          it { should have_title('Sign in') }
        end

        describe "visiting the user index" do
          before { visit instructors_path }
          it { should have_title('Sign in') }
        end
      end
    end
  
   describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      
      before { sign_in user, no_capybara: true }

      describe "submitting a GET request to the Users#edit action" do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match(full_title('Edit user')) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end

    describe "as wrong instructor" do
      let(:instructor) { FactoryGirl.create(:instructor) }
      let(:wrong_instructor) { FactoryGirl.create(:instructor, email: "wrongwrong@example.com") }
      
      before { sign_in instructor, no_capybara: true }

      describe "submitting a GET request to the Users#edit action" do
        before { get edit_instructor_path(wrong_instructor) }
        specify { expect(response.body).not_to match(full_title('Edit instructor')) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a PATCH request to the Users#update action" do
        before { patch instructor_path(wrong_instructor) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end


     describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin, no_capybara: true }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end

    describe "as non-admin instructor" do
      let(:instructor) { FactoryGirl.create(:instructor) }
      let(:non_admin) { FactoryGirl.create(:instructor) }

      before { sign_in non_admin, no_capybara: true }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete instructor_path(instructor) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end
  end
end