class ReportsController < ApplicationController

  helper ReportsHelper

	def index
    @post = Post.find(params[:post_id])
    @reports = @post.reports.all.sort_by{|e| e[:quarter]}

  end
  
  def new
    @post = Post.find(params[:post_id])
    @report = @post.reports.build
  end
  
  def create
    @post = Post.find(params[:post_id])
    @report = @post.reports.build(reports_params)
    
    if @report.save
      redirect_to post_reports_path, :notice => "New report was added successfully"
    else
      render "new"
    end
  end
  
  def edit
    @post = Post.find(params[:post_id])
    @report = @post.reports.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:post_id])
    @report = @post.reports.find(params[:id])
    
    if @report.update_attributes(reports_params)
      redirect_to post_reports_path, :notice => "Report information was updated successfully"
    else
      render "edit", :notice => "Report information was not updated"
    end

    
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    @report = @post.reports.find(params[:id])
    @report.destroy
    redirect_to post_reports_path, :notice => "The report was deleted"
  end
  
 

  
  private
    # Using a private method to encapsulate the permissible parameters is
    # just a good pattern since you'll be able to reuse the same permit
    # list between create and update. Also, you can specialize this method
    # with per-user checking of permissible attributes.
    def reports_params
      params.require(:report).permit(:quarter, :date_of_report, :units, :shares_outstanding, :high_price, :low_price, :percent_of_gov_income, :revenue, :opp_exp, 
        :ga_exp, :rent, :depreciation, :interest_exp, :tax, :net_income, :tax_rate, :assets, :cash, :curr_assets, :goodwill, :fixed_assets, :curr_liab, :curr_debt, 
        :lt_debt, :equity)
    end

    helper_method :our_price
end
