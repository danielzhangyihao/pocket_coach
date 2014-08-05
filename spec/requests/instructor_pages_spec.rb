require 'spec_helper'

describe "Instructor pages" do

  subject { page }

  describe "instructor page" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      sign_in user
      visit instructors_path
    end

    it { should have_title('All instructors') }
    it { should have_content('All instructors') }
    it { should_not have_link('delete') }
    
    describe "pagination" do

      before (:all) { 31.times { FactoryGirl.create(:instructor) } }
      after(:all)  { Instructor.delete_all
                     Company.delete_all
                     }

      it { should have_selector('div.pagination') }
      it { should have_selector('li') }

      it "should list each instructor" do
        Instructor.paginate(page: 1).each do |instructor|
          expect(page).to have_selector('li', text: instructor.name)
        end
      end
    end
  end 

end
