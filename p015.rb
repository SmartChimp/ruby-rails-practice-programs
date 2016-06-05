# p015.rb
# Exception example in ruby

begin
	raise "throw exception..."
rescue Exception => e
	puts "Exception occurred : "+e.to_s
ensure
	puts "Things are ensured to execute as expected"
end

puts "Test one is done..."


begin
	raise "throw exception 2..."
rescue Exception => e
	puts "Exception occurred : "+e.to_s
	#exit
ensure
	# Ensure block get executed even the program encounters exit statement.
	puts "Things are ensured to execute as expected"
end

puts "Everything got over.."
