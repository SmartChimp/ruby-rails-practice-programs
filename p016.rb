# p016.rb
# throw catch in Ruby

def promptAndGet(prompt)
	puts 'in promptAndGet'
   print prompt
   res = readline.chomp
   puts res
 catch :quitRequested do
	puts 'in catch'
   name = promptAndGet("Name: ")
   age = promptAndGet("Age: ")
   sex = promptAndGet("Sex: ")
   # ..
   # process information
end
   
   throw :quitRequested if res == "!"


   return res

end


puts 'in outer'
promptAndGet("Name:")