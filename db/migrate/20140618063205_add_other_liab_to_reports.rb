class AddOtherLiabToReports < ActiveRecord::Migration
  def change
  	  	add_column :reports, :other_liabilities, :integer
  	  	add_column :reports, :other_assets, :integer
	
	Report.reset_column_information
	
	Report.all.each do |r| 
		r.other_liabilities = r.total_liabilities - r.curr_liab - r.lt_debt
		r.other_assets = r.assets - r.curr_assets - r.goodwill - r.fixed_assets
		r.save
	end
  end
end
