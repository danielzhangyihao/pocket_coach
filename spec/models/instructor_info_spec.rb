require 'spec_helper'

describe InstructorInfo do
  let(:instructor) { FactoryGirl.create(:instructor) }
  before{ 
  	@instructorinfo= InstructorInfo.create(description:"a",price:"3.99")
  	instructor.instructor_info=@instructorinfo}
  
  subject { @instructorinfo}

  it { should respond_to(:description) }
  it { should respond_to(:price)}

  it { should respond_to(:instructor_id) }
  
end
