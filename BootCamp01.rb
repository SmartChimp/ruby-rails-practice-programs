# BootCamp01.rb
# print polynomial equation.

print 'Enter coefficient values as comma separated values  : '
comma_seperated_values = gets
coefficients = comma_seperated_values.split(pattern =",")
total_size = coefficients.size

if total_size < 2 then 
	puts 'Your have entered invalid number of coefficients. it must have atleast 2 values.'
end

final_str = "";

coefficients.each do |value|
	total_size -= 1
	int_value = value.to_i
	puts 'int value :' +int_value.to_s
	if(int_value == 0)
		next
	elsif (int_value < 0) then
		final_str += value
	else
		if(final_str.empty?) then
			final_str += value
		else 
			final_str += "+" + value
		end
	end
	
	if(total_size > 1) then
		final_str += "x^"+total_size.to_s
	elsif total_size == 1 then
		final_str += "x"
	end 
end

puts final_str

