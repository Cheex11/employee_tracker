require 'active_record'
require './lib/employee'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  puts "Welcome to the Employee Tracker (c 1987)!"
  menu
end

def menu
  choice = nil
  until choice == 'e'
    puts "Press 'a' to add an employee, 'l' to list your employees."
    puts "Press 'e' to exit."
    choice = gets.chomp
    case choice
    when 'a'
      add
    when 'l'
      list
    when 'e'
      puts "Good-bye!"
    else
      puts "Sorry, that wasn't a valid option."
    end
  end
end

def add
  puts "What is the name of the employee you would like to add to my system?"
  employee_name = gets.chomp
  employee = Employee.new({:name => employee_name})
  employee.save
  puts "'#{employee_name}' has been added to your work force."
end

def list
  begin
    puts "Here is a list of your employees currently in my system:"
    employees = Employee.all
    employees.each { |employee| puts ("#{employee.name}  #{employee.division}") }

    puts "Type add [DIVISION] , [EMPLOYEE] to add an employee to a division."
    puts "Type delete [EMPLOYEE] to delete an employee"
    puts "Type "
    puts "Type main to return to the main menu."
    input = gets.chomp.split
    case input[0]
    when 'main'
      menu
    when 'delete'
      input.shift
      input.join(' ')
      input = Employee.find_by(name: input)
      input.destroy
    else 'and'
      input.shift
      input = input.join(' ').split(",")
      employee = Employee.find_by(name: input[1])
      employee.update(division: input[0])
    end
  rescue
    puts 'FATAL ERROR'
    menu
  end
end

welcome
