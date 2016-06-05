# p012.rb
# hash in Ruby

hash_one  = Hash.new

hash_one["1"] = 100

hash_one["2"] = 200

hash_one["3"] = 300

hash_one["4"] = 400


puts "value at hash_one[\"4\"] is #{hash_one["4"]}"


hash_one["4"] = hash_one["4"] * 2


puts "value at hash_one[\"4\"] * 2 is #{hash_one["4"]}"


puts "is the has contains the value 800 #{hash_one.value?(800)}"