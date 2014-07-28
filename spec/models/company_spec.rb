require 'spec_helper'

describe Company do
  before{ @company= Company.new(name:"MMB")}
  subject { @company}


  it { should respond_to(:name) }

end
