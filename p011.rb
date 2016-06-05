# p011.rb
# Arrays in Ruby


puts "---------------------------------"

arr_type_1 = Array.new

arr_type_1[0] = "Zero"
arr_type_1[1] = "One"

puts arr_type_1

puts "---------------------------------"

arr_type_2 = Array.new(10) { "test" }

arr_type_2.each do |i|
	puts i
end

puts "---------------------------------"

arr_type_3 = Array(1..10) 

arr_type_3.each do |i|
	puts i
end

puts "---------------------------------"

arr_type_4 = Array[1,2,3,4,5]

arr_type_4.each do |i|
	puts i
end

puts "---------------------------------"

arr_type_5 = Array.[](1,2,3,4,5,6,7)

arr_type_5.each do |i|
	puts i
end

puts "---------------------------------"

arr_type_6 = Array.new(10) { |i| i=i*2}

arr_type_6.each do |i|
	puts i
end

puts "---------------------------------"

arr_type_7 = arr_type_6 * "times "

puts arr_type_7
puts arr_type_7.size

arr_type_8 = arr_type_7.split(pattern=" ")


arr_type_8.each do |i|
	puts i + ','
end


