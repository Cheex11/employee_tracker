require 'spec_helper'

describe Employee do
  it 'creates a new employee and saves it to the database' do
    new_employee = Employee.new({'name' => 'Milton'}) #runs save as well
    new_employee.save
    Employee.all.should eq [new_employee]
  end

  it { should have_and_belong_to_many :projects }
end



  # it { should have_many_and_belong_to :projects }
