# p005.rb
# select case and unless examples

print 'Enter language : '

# chomp method will remove the new line character at the end of input. 


value = gets.chomp

case value
	when 'English', 'english'
		puts 'Its good.'
	when 'Spanish', 'spanish'
		puts 'bueno'
	when 'Tamil', 'tamil'
		puts 'நன்று'
	else
		puts 'Not applicable'
end

print 'Enter value : '
value = gets

puts 'With out chomp : '+ value + '.'

puts 'With chomp : ' + value.chomp + '.'


# String with single and double quotes

=begin
Character sequence with single quotes doesn't allow substitution and allows backslash character for only single quote and 
backslash.(Ex: \\,\').

String with double quotes allow substitution and backspace character. Substitution in string is identified by #{}, expression 
inside the curly braces get executed.
=end


puts 'I couldn\'t do it, because it\'s backslash \\'

puts "Sum of (2+3+4-90) is #{2+3+4-90} \b"
