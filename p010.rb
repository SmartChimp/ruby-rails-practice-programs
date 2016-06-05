# p010.rb
# block in Ruby



def create_banner
	yield
	puts 'Hi this is Freddy, official spoke person of Freshdesk. Glad to welcome our new joinee Kalyan to our team.'
	str = "Hi, how are you doing."
	puts str.upcase

end

create_banner {
	puts '------------------------------'
	puts "\n\t\tFreshdesk"
	puts "\n------------------------------"
}