#!/Usr/bin/env ruby
#Let's put all student into an array
@students = []

def input_students(spell)
  puts "Please enter the name of the students"
  puts "To finish, hit enter twice"
  #Get the first name
  name = STDIN.gets.delete("\n")
  #While the name is not empty, repeat this code
  while !name.empty? do
    while true do
      puts "Which cohort is #{name} in?"
      month = STDIN.gets.delete("\n").downcase.capitalize.to_sym
      month = :November if month.empty?
      break if spell.call(month) != false
      puts "I'm afraid '#{month}' is not a real cohort."
    end
    puts "What is #{name}'s nationality?"
    nationality = STDIN.gets.delete("\n").to_sym
    shovel_students(name, month, nationality)
    puts "Now we have #{@students.count} student" + ( @students.count > 1 ? "s" : "")
    name = gets.chomp
  end
end

def try_load_students
  filename = ARGV.first
  filename = "students.csv" if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} students from #{filename}"
  else
    puts "The file #{filename} doesn't exist."
    exit
  end
end

def execute_start
  if !File.exist?("students.csv")
    file = File.open("students.csv", "w")
    file.close
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

def shovel_students(name, cohort, nationality)
  @students << {name: name, cohort: cohort.to_sym, nationality: nationality.to_sym}
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each { |line|
    name, cohort, nationality = line.chomp.split(",")
    shovel_students(name, cohort, nationality)
  }
  file.close
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
  puts "4. Load the list from students.csv"
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
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

def interactive_menu(spell_check)
  loop do
    print_menu
    process(STDIN.gets.chomp, spell_check)
  end
end

execute_start
try_load_students
interactive_menu(spell_check)
