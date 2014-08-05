require 'spec_helper'

describe Instructor do
  before { @company=Company.create(name:"NBA")
           @instructor = @company.instructors.build(name: "Example User", email: "user@example.com",
  	       password: "foobar", password_confirmation: "foobar", facility:"NBA")
           

  }

  subject { @instructor }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:companyadmin) }
  it { should respond_to(:facility)}
  it { should respond_to(:remember_token) }
  it { should respond_to(:company_id)}
  

  describe "with companyadmin attribute set to 'true'" do
    before do
      @instructor.save!
      @instructor.toggle!(:companyadmin)
    end

    it { should be_companyadmin }
  end

  describe "when name is not present" do
    before { @instructor.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @instructor.email = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @instructor.facility = " " }
    it { should_not be_valid }
  end

   describe "when name is too long" do
    before { @instructor.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when company_id is not present" do
    before{ @instructor.company_id=nil}
    it { should_not be_valid}
  end


  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @instructor.email = invalid_address
        expect(@instructor).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @instructor.email = valid_address
        expect(@instructor).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @instructor.dup
      user_with_same_email.email = @instructor.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when password is not present" do
    before do
           @company=Company.create(name:"NBA")
           @instructor = @company.instructors.build(name: "Example User", email: "user@example.com",
           password: " ", password_confirmation: " ", facility:"NBA")
      
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @instructor.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @instructor.password = @instructor.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @instructor.save }
    let(:found_instructor) { Instructor.find_by(email: @instructor.email) }

    describe "with valid password" do
      it { should eq found_instructor.authenticate(@instructor.password) }
    end

    describe "with invalid password" do
      let(:instructor_for_invalid_password) { found_instructor.authenticate("invalid") }

      it { should_not eq instructor_for_invalid_password }
      specify { expect(instructor_for_invalid_password).to be_false }
    end
  end

  describe "remember token" do
    before { @instructor.save }
    its(:remember_token) { should_not be_blank }
  end
end


