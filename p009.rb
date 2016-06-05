# p009.rb
# methods in Ruby.

def empty_param
	puts "Inside empty param method."
end

def pass_param( param_1, param_2)
	puts "Inside pass_param method the values passed are #{param_1} and #{param_2}"
end

def pass_param_with_default( param_1="ruby", param_2 = "java")
	puts "Inside pass_param_with_default with the param values #{param_1} and #{param_2}"
	if(param_1.eql?("ruby")) then
		puts "param_1 is a default value."
	end
	if(param_2.eql?("java")) then
		puts "param_2 is a default value."
	end
end

def return_nil
	puts "Inside return nil method."
	return
end

def return_multiple_values
	puts "Inside return multiple values"
	return 100, 200, 300
end

empty_param
pass_param 238, 'kalyan'
pass_param_with_default
pass_param_with_default('Go')
puts return_nil # this doesn't print any character
return_value = return_multiple_values
return_value.each do |val|
	print "#{val}, "
end
puts