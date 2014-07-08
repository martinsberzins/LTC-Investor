module ReportsHelper

	def if_na(number)
		if number == 0.00
			number = "NA"
		else
			number = number_to_percentage(number, precision: 2)
		end
	end

end
