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
    puts "Press 'a' to add an employee, 'l' to list."
    puts "Press 'e' to exit."
    choice = gets.chomp
    case choice
    when 'a'
      add
    when 'l'
      puts 'what does thou wanteth to listeth.'
      puts 'thy options are: employees(e), employees in a division(d), employees working on a project(p).'
      case gets.chomp
      when 'e'
        system('clear')
        list_employees
      when 'd'
        system('clear')
        list_divisions
        puts 'What division do you want to see employees for?'
        list_employees_by_division(gets.chomp)
      when 'p'
        system('clear')
        list_projects
        puts 'What project do you want to see employees for?'
        list_employees_by_project(gets.chomp)
      else
        puts 'error'
        sleep(2)
        menu
      end
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
  employee = Employee.new({:name => employee_name, :project => 'unassigned', :division => 'unassigned'})
  employee.save
  puts "'#{employee_name}' has been added to your work force."
end

def list_employees
  begin
    puts "Here is a list of your employees currently in my system:"
    employees = Employee.all
    employees.each { |employee| puts ("#{employee.name}  #{employee.division}, #{employee.project}") }

    puts "Type add_div [DIVISION] , [EMPLOYEE] to add an employee to a division."
    puts "Type add_pro [PROJECT], [EMPLOYEE] to add an employee to a project"
    puts "Type delete [EMPLOYEE] to delete an employee"
    puts "Type main to return to the main menu."
    input = gets.chomp.split
    print input
    case input[0]
    when 'main'
      menu
    when 'delete'
      input.shift
      input = Employee.find_by(name: input.join(' '))
      input.destroy
    when 'add_div'
      input.shift
      input = input.join(' ').split(",")
      employee = Employee.find_by(name: input[1])
      employee.update(division: input[0])
    when 'add_pro'
      input.shift
      input = input.join(' ').split(",")
      employee = Employee.find_by(name: input[1])
      employee.update(project: input[0])
    else
      puts 'please try again'
    end
  rescue
    puts 'FATAL ERROR'
    menu
  end
end

def list_divisions
  employees = Employee.all
  emp = []
  employees.each { |employee| emp << employee.division }
  emp.uniq!
  puts emp.join(', ')
end

def list_employees_by_division(division)
  employees = Employee.where(division: division)
    employees.each { |employee| puts ("#{employee.name}") }
  menu
end

def list_projects
  employees = Employee.all
  emp = []
  employees.each { |employee| emp << employee.project }
  emp.uniq!
  puts emp.join(', ')
end

def list_employees_by_project(project)
  employees = Employee.where(project: project)
    employees.each { |employee| puts ("#{employee.name}") }
  menu
end

welcome
