#!/Usr/bin/env ruby
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = [] # array brackets
  # get the first name
  name = gets.chomp #space between methods
  # while the name is not empty, repeat this code
  while !name.empty? do #when will not loop back. Also ! needed for NOT and ? for test
    # add the student hash to the array
    students << {name: name, cohort: :november} # < -- conditional not push (<<).
    # Colon used for symbols, not needed for the string 'name'. Comma to separate the symbols.
    puts "Now we have #{students.count} students" # 'student' does not exist as a variable
    # Cannot apply method upon it
    # get another name from the user
    name = gets.chomp # gets
  end
  # return the array of students
  students
end

def print_header # - (subtract) not allowed in variable names
  puts "The students of my cohort at Makers Academy" #puts
  puts "-------------" #`` used for files and directories
end

def print(students)
  students.each do |student| # || needed to state parameter. students as in def print(students)
    puts "#{student[:name]} (#{student[:cohort]} cohort)" #[] for index {} for interpolation
  end # single quotes cannot do interpolation
end

def print_footer names
  puts "Overall, we have #{names.count} great students" #prints is not a defined method
  #also print has been defined as a different method and cannot be used on this string
end


students = input_students
print_header
print(students) #When passing method on variable must use ()
print_footer(students) # ""
