# p004.rb
# logical operators in ruby.

value_a = 789
value_b = 4
max_value = 90

if (value_a > value_b)
	if (value_a < max_value)
		puts 'value_a is greater then value_b, but less than max_value'
	else
		puts 'value_a is greater than value_b and greater than max_value'
	end
elsif (value_b == value_a) 
	puts 'value_a is equal to value_b'
else 
	puts 'value_a is less than value_b'
end

puts 'logical operators test'

puts (true && true)

puts (true || false)

puts (!true)

# ternary operator.

puts ( 5 < 10) ? 'Five is not greater than ten.' : 'Five is greater than ten.' 


if (5 > 10) then puts 'Five is greater than ten' else puts 'Five is less than ten.' end