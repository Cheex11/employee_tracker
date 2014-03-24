require 'rspec'
require 'employee'

describe 'Employee' do
  it 'creates a new employee and saves it to the database' do
    new_employee = Employee.create({'name' => 'Milton'}) #runs save as well
    Employee.all.should eq [new_employee]
  end
end
