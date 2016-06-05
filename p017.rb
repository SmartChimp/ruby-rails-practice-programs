# p017.rb
# class and objects

class Sample
	public @test_var
	def testMethod(company, params = {})
		@name = params[:name]
		@email = params[:email]
		@company = company
	end

	def print
		puts "#{@name} works @ #{@company}, you can email to #{@email}"
	end
end


obj = Sample.new
puts obj.class
puts obj.class.superclass
puts obj.class.superclass.superclass
puts obj.class.superclass.superclass.superclass

obj.testMethod 'Freshdesk', :name => 'kalyan', :email => 'kalyan@freshdesk.com'

obj.print
obj.print

# property visibility
puts "Accessable : #{obj.test_var}"
