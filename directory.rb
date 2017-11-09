#!/Usr/bin/env ruby
#Let's put all student into an array
def input_students(spell)
  puts "Please enter the name of the students"
  puts "To finish, hit enter twice"
  #Create an empty array
  students = []
  #Get the first name
  name = gets.delete("\n")
  #While the name is not empty, repeat this code
  while !name.empty? do
    while true do
      puts "Which cohort is #{name} in?"
      month = gets.delete("\n").downcase.capitalize.to_sym
      month = :November if month.empty?
      break if spell.call(month) != false
      puts "I'm afraid '#{month}' is not a real cohort."
    end
    puts "What is #{name}'s nationality?"
    nationality = gets.delete("\n").to_sym
    students << {name: name, nationality: nationality, cohort: month}
    puts "Now we have #{students.count} student" + ( students.count > 1 ? "s" : "")
    name = gets.chomp
  end
  return students
end

$Existing_cohorts = [:January, :February, :March, :April, :May, :June, :July, :August, :September, :October, :November, :December]
$listNo = 1

spell_check = Proc.new { |month|
  checkr = 0
  $Existing_cohorts.each { |correct|
    checkr += 1 if month != correct
  }
  false if checkr == 12
}

def print_header
  puts "The students of Villains Academy"
  puts "------------"
end

def print(students)
  $Existing_cohorts.each { |month|
    checker = 0
    while students.length > checker do
      if month == students[checker][:cohort]
        puts "#{$listNo}. #{students[checker][:name]}\n" +
        "    Nationality: #{students[checker][:nationality]}\n" +
        "    (#{students[checker][:cohort]} cohort)"
        $listNo += 1
      end
      checker += 1
    end
  }
end

def print_footer(names)
  puts "Overall, we have #{names.count} great student"  + ( names.count > 1 ? "s" : "")
end
#Calling the methods
students = input_students(spell_check)
if students.count > 0
  print_header
  print(students)
  print_footer(students)
else
  puts "No students"
end
