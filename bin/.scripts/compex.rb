# Solves wire problem from KTANE game

def complex_wires()
  print "color? -> "
  color = gets.chomp
  print "symbol? -> "
  symbol = gets.chomp
  print "LED? -> "
  led = gets.chomp

  if color == "w" && symbol = "n" && led = "n"
    puts "Cut that bitch!"
  elsif color == "w" && symbol = "y" && led = "n"
    puts "Cut that bitch!"
  elsif color == "w" && symbol = "n" && led = "y"
    puts "Don't cut!"
  elsif color == "w" && symbol = "y" && led = "y"
    puts "Cut if 2 or more batteries!"
  elsif color == "r" && symbol = "n" && led = "n"
    puts "Cut if even serial number!"
  elsif color == "r" && symbol = "y" && led = "n"
    puts "Cut that bitch!"
  elsif color == "r" && symbol = "y" && led = "y"
    puts "Cut if 2 or more batteries!"
  elsif color == "r" && symbol = "n" && led = "y"
    puts "Cut if 2 or more batteries!"
  elsif color == "b" && symbol = "y" && led = "y"
    puts "Cut if parallel port!"
  elsif color == "b" && symbol = "y" && led = "n"
    puts "Don't cut!"
  elsif color == "b" && symbol = "n" && led = "n"
    puts "Cut if even serial number!"   
  elsif color == "b" && symbol = "n" && led = "y"
    puts "Cut if parallel port!"
  elsif color == "rb" && symbol = "y" && led = "n"
    puts "Cut if parallel port!"
  elsif color == "rb" && symbol = "y" && led = "y"
    puts "Don't cut!"
  elsif color == "rb" && symbol = "n" && led = "n"
    puts "Cut if even serial number!"
  elsif color == "rb" && symbol = "n" && led = "y"
    puts "Cut if even serial number!"
  else
    puts "You messed up!"                        
  end
end

complex_wires()
