# p008.rb
# loop example programs.

# while loop

puts 'say hai to cherry 5 times using while loop.'

times = 0

while (times < 5) do
	puts 'hai Cherry!!'
	times += 1
end

times = 0

times += 1 while (times < 5)

puts "value of times after second loop #{times}"

#following is like do while 

puts 'say hi to Donuts, 5 times. with value of times as 5'

times = 5

begin
	puts 'hai Donut!!!'
end while (times <5)


# Until loop

times = 0

puts 'Say hai to Sandwitch, 5 times using until loop.'

until (times >= 5)
	puts 'Hai Sandwitch!!!'
	times += 1 
end

# for loop

puts 'Say hi to karupatti, 5 times using for loop.'

for i in (0...5) do
	puts "Hi Karupatti..!!! #{i}"
end

# retry keyword example

count = 1

begin
	count += 1;
	put 'Some exception'
rescue Exception => e
	puts 'Exception occurred : ' + e.to_s
	retry if (count < 4)
end
