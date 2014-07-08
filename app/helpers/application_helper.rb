module ApplicationHelper
	def format_date(date)
		date = date.to_s
		date = date[4,12]
		date
	end
end
