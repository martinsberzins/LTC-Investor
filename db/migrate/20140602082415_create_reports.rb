class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :quarter
      t.date :date_of_report
      t.integer :units
      t.integer :shares_outstanding
      t.float :high_price
      t.float :low_price
      t.float :percent_of_gov_income
      t.integer :revenue
      t.integer :opp_exp
      t.integer :ga_exp
      t.integer :rent
      t.integer :depreciation
      t.integer :interest_exp
      t.integer :tax
      t.integer :net_income
      t.float :tax_rate
      t.integer :assets
      t.integer :cash
      t.integer :curr_assets
      t.integer :goodwill
      t.integer :fixed_assets
      t.integer :curr_liab
      t.integer :curr_debt
      t.integer :lt_debt
      t.integer :equity

      t.timestamps
    end
  end
end
