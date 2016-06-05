# p007.rb
# Array, Range and Hashes in Ruby.

# Array

array_of_elem = [1, 56.0, "nothing to do"]

print "Elements of array : "

array_of_elem.each_with_index do |elem, index|
	puts "Value at position #{index + 1} is #{elem}"
end

# Range

puts "Following values are printed using range values with (10..20) : "

(10..20).each_with_index {
	|elem, index| 
	puts "#{index} -> #{elem}"
}

puts "Following values are printed using range values with (10...20) : "

(10...20).each_with_index {
	|elem, index| 
	puts "#{index} -> #{elem}"
	puts ":) :)"
}


# Hashes

hash_of_values = { "kalyan" => "pipemonk", "chandru" => "cts", "dilip" => "rexit", "magesh" => "zoho"}

hash_of_values.each {
	|key, value|
	puts "................................"
	puts "key : #{key}, value : #{value}"
}