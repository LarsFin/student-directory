#!/Usr/bin/env ruby
#Let's put all student into an array
@students = []

def input_students(spell)
  puts "Please enter the name of the students"
  puts "To finish, hit enter twice"
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
    @students << {name: name, nationality: nationality, cohort: month}
    puts "Now we have #{@students.count} student" + ( @students.count > 1 ? "s" : "")
    name = gets.chomp
  end
end

def save_students
  file = File.open("students.csv", "w")
  @students.each { |student|
    student_data = [student[:name], student[:cohort], student[:nationality]]
    csv_line = student_data.join(",")
    file.puts csv_line
  }
  file.close
  puts "List saved to students.csv"
end

@Existing_cohorts = [:January, :February, :March, :April, :May, :June, :July, :August, :September, :October, :November, :December]

spell_check = Proc.new { |month|
  checkr = 0
  @Existing_cohorts.each { |correct|
    checkr += 1 if month != correct
  }
  false if checkr == 12
}

def print_header
  puts "The students of Villains Academy"
  puts "------------"
end

def print_students_list
  listNo = 1
  @Existing_cohorts.each { |month|
    checker = 0
    while @students.length > checker do
      if month == @students[checker][:cohort]
        puts "#{listNo}. #{@students[checker][:name]}\n" +
        "    Nationality: #{@students[checker][:nationality]}\n" +
        "    (#{@students[checker][:cohort]} cohort)"
        listNo += 1
      end
      checker += 1
    end
  }
end

def print_footer
  puts "Overall, we have #{@students.count} great student"  + ( @students.count > 1 ? "s" : "")
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process(selection, spell_check)
  case selection
  when "1"
    input_students(spell_check)
  when "2"
    if @students.count > 0
      show_students
    else
      puts "No students to show"
    end
  when "9"
    exit
  when "3"
    save_students
  else
    puts "I don't know what you meant, try again"
  end
end

def interactive_menu(spell_check)
  loop do
    print_menu
    process(gets.chomp, spell_check)
  end
end

interactive_menu(spell_check)
