# to get input from user we have to use gets method.

print 'Enter value of a : '

first_num = gets.to_i

print 'Enter value of b : '

second_num = gets.to_i

puts 'value of ' + first_num.to_s + ' + ' + second_num.to_s + ' = ' + (first_num+second_num).to_s

puts 'value of ' + first_num.to_s + ' - ' + second_num.to_s + ' = ' + (first_num-second_num).to_s

puts 'value of ' + first_num.to_s + ' / ' + second_num.to_s + ' = ' + (first_num/second_num).to_s

puts 'value of ' + first_num.to_s + ' * ' + second_num.to_s + ' = ' + (first_num*second_num).to_s

puts 'value of ' + first_num.to_s + ' % ' + second_num.to_s + ' = ' + (first_num%second_num).to_s

# preceding ? on value with ord method will return ASCII value of that character. 

int_value = ?a.ord

puts 'value of a : ' + int_value.to_s