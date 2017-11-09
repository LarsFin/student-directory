#!/Usr/bin/env ruby
#Let's put all student into an array
def input_students(spell)
  puts "Please enter the name of the students"
  puts "To finish, hit enter twice"
  #Create an empty array
  students = []
  #Get the first name
  name = gets.chomp
  #While the name is not empty, repeat this code
  while !name.empty? do
    while true do
      puts "Which cohort is #{name} in?"
      month = gets.chomp.downcase.capitalize.to_sym
      month = :November if month.empty?
      break if spell.call(month) != false
      puts "I'm afraid '#{month}' is not a real cohort."
    end
    puts "What is #{name}'s nationality?"
    nationality = gets.chomp
    students << {name: name, nationality: nationality, cohort: month}
    puts "Now we have #{students.count} students"
    name = gets.chomp
  end
  return students
end

spell_check = Proc.new { |month|
  correct_months = [:January, :February, :March, :April, :May, :June, :July, :August, :September, :October, :November, :December]
  checkr = 0
  correct_months.each { |correct|
    checkr += 1 if month != correct
  }
  false if checkr == 12
}

def print_header
  puts "The students of Villains Academy"
  puts "------------"
end

def print(students)
  checker = 0
  while students.length > checker do
    puts "#{checker + 1}. #{students[checker][:name]}
    Nationality: #{students[checker][:nationality]}
    (#{students[checker][:cohort]} cohort)"
    checker += 1
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end
#Calling the methods
students = input_students(spell_check)
print_header
print(students)
print_footer(students)
