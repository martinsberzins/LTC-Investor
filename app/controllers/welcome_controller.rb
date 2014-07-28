class WelcomeController < ApplicationController
  require 'nokogiri'
  require 'open-uri'

  def index
    posts = Post.all

    tickers = "" 
    posts.each do |p|
      tickers += p.ticker.to_s+"+"
    end

    url = "http://finance.yahoo.com/rss/industry?s="+tickers
    doc = Nokogiri::XML(open(url))
    titles_hold = doc.css("item title")
    links_hold = doc.css("item link")
    descriptions_hold = doc.css("item description")
    pubDate_hold = doc.css("item pubDate")

    @titles = trim_namespace(titles_hold, "title")
    @links = trim_namespace(links_hold, "link")
    @descriptions = trim_namespace(descriptions_hold, "description")
    @pubDate = trim_namespace(pubDate_hold, "pubDate")


  end
  private

  helper_method :our_price, :recomendation, :get_data, :trim_namespace, :make_recommendation
end




