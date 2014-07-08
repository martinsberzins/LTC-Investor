class Report < ActiveRecord::Base
	belongs_to :post

	after_save :calculate_fields

	private
	def calculate_fields   
	  other_assets = self.assets - self.curr_assets - self.goodwill - self.fixed_assets
      total_liabilities = self.assets - self.equity
      other_liabilities = total_liabilities - self.curr_liab - self.lt_debt
	  
	  self.update_column(:other_assets, other_assets)
      self.update_column(:total_liabilities, total_liabilities)
      self.update_column(:other_liabilities, other_liabilities)
  	end
end
