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
    puts "What is #{name}'s favourite hobby?"
    hobby = gets.chomp
    puts "What is #{name}'s nationality?"
    nationality = gets.chomp
    students << {name: name, hobby: hobby, nationality: nationality, cohort: :november}
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
    puts "#{checker + 1}. #{students[checker][:name]}
    Hobby: #{students[checker][:hobby]}
    Nationality: #{students[checker][:nationality]}
    (#{students[checker][:cohort]} cohort)"
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
