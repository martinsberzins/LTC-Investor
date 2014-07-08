class AddCalculatedFieldsToReports < ActiveRecord::Migration
  def change
  	add_column :reports, :total_liabilities, :integer
	Report.reset_column_information
	
	Report.all.each do |r| 
		r.total_liabilities = r.assets - r.equity
		r.save
	end
  end
end
