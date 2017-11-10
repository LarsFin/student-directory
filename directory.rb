#!/Usr/bin/env ruby
#Let's put all student into an array
@students = []

def input_students(proc1)
  puts "Please enter the name of the students\nTo finish, hit enter twice"
  name = STDIN.gets.delete("\n")
  while !name.empty? do
    month = input_cohort(proc1, name)
    puts "What is #{name}'s nationality?"
    nationality = STDIN.gets.delete("\n").to_sym
    shovel_students(name, month, nationality)
    puts "Now we have #{@students.count} student" + ( @students.count > 1 ? "s" : "")
    name = gets.chomp
  end
end

def input_cohort(proc1, name)
  while true do
    puts "Which cohort is #{name} in?"
    month = STDIN.gets.delete("\n").downcase.capitalize.to_sym
    month = :November if month.empty?
    break if proc1.call(month) != false
    puts "I'm afraid '#{month}' is not a real cohort."
  end
  month
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

def save_students(filename)
  File.open(filename, "w"){ |file|
    @students.each { |student|
      student_data = [student[:name], student[:cohort], student[:nationality]]
      csv_line = student_data.join(",")
      file.puts csv_line
    }
  }
  puts "List successfully saved to #{filename}"
end

def state_file(saveORload)
  while true
    filename = STDIN.gets.delete("\n")
    break if saveORload == "save"
    File.exist?("#{filename}") ? break : puts("#{filename} does not exist, try again")
  end
  return filename
end

def shovel_students(name, cohort, nationality)
  @students << {name: name, cohort: cohort.to_sym, nationality: nationality.to_sym}
end

def load_students(filename = "students.csv")
  @students = []
  File.open(filename, "r"){ |file|
    file.readlines.each { |line|
      name, cohort, nationality = line.chomp.split(",")
      shovel_students(name, cohort, nationality)
    }
  }
  puts "List successfully loaded from #{filename}"
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
  @listNo = 1
  @Existing_cohorts.each { |month|
    checker = 0
    while @students.length > checker do
      puts_info(checker) if month == @students[checker][:cohort]
      checker += 1
    end
  }
end

def puts_info(checker)
  puts "#{@listNo}. #{@students[checker][:name]}\n" +
  "    Nationality: #{@students[checker][:nationality]}\n" +
  "    (#{@students[checker][:cohort]} cohort)"
  @listNo += 1
end

def print_footer
  puts "Overall, we have #{@students.count} great student"  + ( @students.count > 1 ? "s" : "")
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to a file"
  puts "4. Load the list from a file"
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process(selection, proc1)
  case selection
  when "1"
    input_students(proc1)
  when "2"
    @students.count > 0 ? show_students : puts("No students to show")
  when "3"
    puts "State the file you wish to save the list to;"
    filename = state_file("save")
    save_students(filename)
  when "4"
    puts "State the file you wish to load the list from;"
    filename = state_file("load")
    load_students(filename)
  when "9"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

def interactive_menu(proc1)
  loop do
    print_menu
    process(STDIN.gets.chomp, proc1)
  end
end

execute_start
try_load_students
interactive_menu(spell_check)
