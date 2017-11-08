#!/Usr/bin/env ruby
#Let's put all student into an array
students = [
  "Dr. Hannibal Lecter",
  "Darth Vader",
  "Bowser",
  "Ganondorf",
  "Manus",
  "The Wicked Witch of the West",
  "Terminator",
  "Freddy Krueger",
  "The Joker",
  "Joffrey Baratheon",
  "Norman Bates"
]

def print_header
  puts "The students of Villains Academy"
  puts "------------"
end

def print(names)
  names.each { |name|
    puts name
  }
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end
#Calling the methods
print_header
print(students)
print_footer(students)
