# business_hours.rb 
# Calculating business hours based on companies working hours.

require 'time'

class BusinessHours

	def initialize(starts_from, ends_at)
		@default_start_from = starts_from
		@default_ends_at = ends_at
		@date_hash = Hash.new
		@closed_days = Hash.new
	end

	def update(date, from, to)
		@date_hash[date] = CustomHours.new(from, to)
	end

	def closed(*date)
		date.each {
			|value|
			@closed_days[value] = value 
		}
	end

	def get_diff_in_seconds(from, to)
		(Time.parse(to) - Time.parse(from))
	end

	def calculate_deadline(estimated_time_in_seconds, from_date)
		given_date = Time.parse from_date
		calculate_time estimated_time_in_seconds, given_date
	end

	def calculate_time(time_in_seconds, date)
		if @closed_days["#{date.strftime("%b")} #{date.day}, #{date.year}"] != nil || @closed_days[get_symbol(date.strftime("%a"))] != nil
			calculate_time time_in_seconds, (date.to_date + 1).to_time
		else
			custom_hours = @date_hash["#{date.strftime("%b")} #{date.day}, #{date.year}"]
			if custom_hours != nil
				return date_manipulation time_in_seconds,custom_hours.get_from, custom_hours.get_to, date
			else
				custom_hours = @date_hash[get_symbol(date.strftime("%a"))]
				if custom_hours != nil
					return date_manipulation time_in_seconds,custom_hours.get_from, custom_hours.get_to, date
				else
					return date_manipulation time_in_seconds,@default_start_from, @default_ends_at, date
				end
			end
		end
	end

	def date_manipulation(time_in_seconds, start, ends, date)
		max_time = get_max_time(Time.parse(start), Time.parse("#{date.hour}:#{date.min+1} "+date.strftime("%P")))
		diff_value = time_in_seconds - (Time.parse(ends) - max_time)
		if diff_value < 0 
			Time.parse("#{date.year}/#{date.month}/#{date.day} #{max_time.hour}:#{max_time.min}:#{max_time.sec}") + time_in_seconds
		else
			calculate_time diff_value, (date.to_date + 1).to_time
		end
	end

	def get_max_time(date_time_one, date_time_two)
		(date_time_two > date_time_one) ? date_time_two : date_time_one
	end

	def get_symbol(day)
		case day
		when "Mon"
			:mon
		when "Tue"
			:tue
		when "Wed"
			:wed
		when "Thu"
			:thu
		when "Fri"
			:fri
		when "Sat"
			:sat
		when "Sun"
			:sun
		end
	end

	def to_s
		@default_range.to_s
	end
end

class CustomHours
	def initialize(from, to)
		@from = from
		@to = to
	end

	def get_from
		@from
	end

	def get_to
		@to
	end

	def get_working_hours_in_seconds
		(Time.parse(@to) - Time.parse(@from))
	end 
end

hours = BusinessHours.new("9:00 AM", "3:00 PM")
hours.update :fri, "10:00 AM", "5:00 PM"
hours.update "Dec 24, 2010", "8:00 AM", "1:00 PM"	
hours.closed :sun, :wed, "Dec 25, 2010"

puts hours.calculate_deadline(2*60*60, "Jun 7, 2010 9:10 AM") # => Mon Jun 07 11:10:00 2010
puts hours.calculate_deadline(15*60, "Jun 8, 2010 2:48 PM") # => Thu Jun 10 09:03:00 2010
puts hours.calculate_deadline(7*60*60, "Dec 24, 2010 6:45 AM") # => Mon Dec 27 11:00:00 2010


	