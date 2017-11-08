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
#and then print them
puts "The students of Villains Academy"
puts "----------"
students.each { |student|
  puts student
}
#Finally, we print out the total number of students
puts "Overall, we have #{students.count} great students"
