#!/Usr/bin/env ruby
def print_source_code
  File.open("#{$0}", "r"){ |file|
    source_code = file.read
  }
end

puts print_source_code
