require 'spec_helper'

describe UserInfo do
	let(:user) { FactoryGirl.create(:user) }
  before{ 
  	@userinfo= UserInfo.create(description:"a",feet:"1",inches:"10",weight:"100.00",school:"berkeley",year:"2015",position:"fg",team:"MMB")
  	user.user_info=@userinfo}
  
  subject { @userinfo}


  it { should respond_to(:description) }
  it { should respond_to(:feet)}

  it { should respond_to(:inches) }
  it { should respond_to(:weight)}

  it { should respond_to(:school) }
  it { should respond_to(:year)}

  it { should respond_to(:position) }
  it { should respond_to(:team)}

  it { should respond_to(:user_id) }
  

end
