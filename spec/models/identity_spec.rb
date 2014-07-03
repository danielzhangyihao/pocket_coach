require 'spec_helper'

describe Identity do

  let(:user) { FactoryGirl.create(:instructor) }
  before {@identity = user.build_identity(school_facility: "Mike Murphy Baseball", position: "pitcher")}
 
  

  subject { @identity }

  it { should respond_to(:school_facility) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:position) }
  its(:user) { should eq user }


  it { should be_valid }

  describe "when user_id is not present" do
    before { @identity.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank school/facility" do
    before { @identity.school_facility = " " }
    it { should_not be_valid }
  end

  describe "with blank position" do
    before { @identity.position = " " }
    it { should_not be_valid }
  end

end