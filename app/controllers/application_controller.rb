class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  require 'nokogiri'
  require 'open-uri'

  protect_from_forgery with: :exception
  
  before_filter :populate_posts, :populate_reports
  
  def populate_posts
    @sidebar_posts = Post.all
  end

  def populate_reports
    @welcome_reports = Report.all
  end

   def our_price(curr, prev)
    #check if there are the reports
    if curr.emtpy? or prev.emtpy?
      curr_our_price = "NA"
    else  
      #variables from current period
      curr_units = curr.units
      curr_no_shares = curr.shares_outstanding
      curr_total_liab = curr.total_liabilities

      #variables from previous period to calculate previous eta/units
      prev_units = prev.units
      prev_no_shares = prev.shares_outstanding
      prev_share_price = (prev.high_price+prev.low_price)/2
      prev_market_cap = prev_no_shares * prev_share_price
      prev_total_liab = prev.total_liabilities
      prev_eta = prev_market_cap + prev_total_liab
      prev_eta_units = prev_eta/prev_units

      #our price for current period
      curr_our_price = (prev_eta_units * curr_units - curr_total_liab)/curr_no_shares
    end
      curr_our_price
  end

  def recomendation(post)
    short_rec = {"Buy" => "B",
              "Sell" => "S",
              "Hold" => "H",
              "Sell (too risky)" => "S (TR)"
    }
    ticker = post.ticker
    price = get_data(ticker, "LastTradePriceOnly")
    reports = post.reports.all.sort_by{|e| e[:quarter]}
    #pagaidu variants, jo bus jaliek NA ari, ja bus tikai viens reports
    if reports.empty?
      recomendation = "NA"
    else
      rec = make_recommendation( post.reports.find(reports[- 1].id), post.reports.find(reports[-2].id), price)
      recomendation = short_rec[rec]
    end
    recomendation
  end

  def get_data (ticker ,namespace)
    url_sp = "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20in%20('"+ticker+"')%0A%09%09&env=http%3A%2F%2Fdatatables.org%2Falltables.env&format=xml"
    doc_sp = Nokogiri::XML(open(url_sp))
    data_holder = doc_sp.css(namespace).to_s
    #trim namespace
    data = trim_namespace(data_holder, namespace)
    data
  end

  def trim_namespace(arr, name)
  result = []
  flen = name.length+2
  blen = flen +2

    if arr.is_a? String
      result = arr[flen..-blen]
    else
      arr.each do |t|
        t = t.to_s
        t = t[flen..-blen]
        result << t
      end
    end
    result
  end

  def make_recommendation (report, report_prev, market_price)
    if report.blank? or report_prev.blank?
      recomendation = "NA"
    else
      market_price = market_price.to_f
      our_price = our_price(report, report_prev)
      pain_treshold = 0.3
      hold_value = 0.03*our_price
      too_high = market_price*(1+pain_treshold)
      too_low = market_price*(1-pain_treshold)
      recomendation = ""

      #decision making tree
      #case1: our price above MP, but too high -> sell, because too high risk
      if too_high < our_price 
        recomendation = "Sell (too risky)"
      #case2: OP between MP and too hign price -> buy
      elsif market_price < our_price && our_price < too_high
        recomendation = "Buy"
      #case3: OP in hold range -> hold
      elsif market_price - hold_value < our_price && our_price < market_price + hold_value
        recomendation = "Hold"
      else
        recomendation = "Sell"
      end
    end
    #return
    recomendation
  end
  
end
