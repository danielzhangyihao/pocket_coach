require 'spec_helper'

describe CompanyInfo do
   let(:company) { FactoryGirl.create(:company) }
   before{ 
  	@companyinfo= CompanyInfo.create(description:"a",address:"5648",telephone:"12345678", email:"jack@gmail.com", price:"3.99")
  	company.company_info=@companyinfo}

  	subject { @companyinfo}

  	it { should respond_to(:description) }
    it { should respond_to(:price)}

    it { should respond_to(:company_id) }
    it { should respond_to(:address) }
    it { should respond_to(:telephone)}

    it { should respond_to(:email) }

end
