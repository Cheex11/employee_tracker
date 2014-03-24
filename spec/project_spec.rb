require 'spec_helper'

describe Project do
  it 'creates a new project and saves it to the database' do
    new_project = Project.new({'name' => 'Annual Review'}) #runs save as well
    new_project.save
    Project.all.should eq [new_project]
  end

  it { should have_and_belong_to_many :employees }
end
