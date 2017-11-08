#!/Usr/bin/env ruby
#Let's put all student into an array
def input_students
  puts "Please enter the name of the students"
  puts "To finish, hit enter twice"
  #Create an empty array
  students = []
  #Get the first name
  name = gets.chomp
  #While the name is not empty, repeat this code
  while !name.empty? do
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    name = gets.chomp
  end
  return students
end

def print_header
  puts "The students of Villains Academy"
  puts "------------"
end

def print(students)
  checker = 0
  while students.length > checker do
    puts "#{checker + 1}." + ("#{students[checker][:name]}").center(20) + ("(#{students[checker][:cohort]} cohort)").center(20)
    checker += 1
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end
#Calling the methods
students = input_students
print_header
print(students)
print_footer(students)
