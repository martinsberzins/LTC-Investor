class PostsController < ApplicationController
  require 'nokogiri'
  require 'open-uri'

  def index
    @posts = Post.all
  end
  
  def show
    @posts = Post.find(params[:id])

    #NEWS
    #get news from Yahoo in XLM
    ticker = @posts.ticker
    url = "http://finance.yahoo.com/rss/headline?s="+ticker
    doc = Nokogiri::XML(open(url))
    #get strings of news items
    titles_hold = doc.css("item title")
    links_hold = doc.css("item link")
    descriptions_hold = doc.css("item description")
    pubDate_hold = doc.css("item pubDate")
    #trim namespaces
    @titles = trim_namespace(titles_hold, "title")
    @links = trim_namespace(links_hold, "link")
    @descriptions = trim_namespace(descriptions_hold, "description")
    @pubDate = trim_namespace(pubDate_hold, "pubDate")

    #STOCK PRICE
    @price = get_data(ticker, "LastTradePriceOnly")
    @currency = get_data(ticker, "Currency")

    #RECOMENDATION
    @reports = @posts.reports.all.sort_by{|e| e[:quarter]}
    @recomendation = make_recommendation(@posts.reports.find(@reports[- 1].id), @posts.reports.find(@reports[-2].id), @price) 
    @our_price = our_price(@posts.reports.find(@reports[- 1].id), @posts.reports.find(@reports[-2].id))
  end
  
  def new
    @posts = Post.new
  end
  
  def create
    @posts = Post.new(posts_params)
    
    if @posts.save
      redirect_to posts_path, :notice => "New company was added successfully"
    else
      render "new"
    end
  end
  
  def edit
    @posts = Post.find(params[:id])
  end
  
  def update
    @posts = Post.find(params[:id])
    
    if @posts.update_attributes(posts_params)
      redirect_to posts_path, :notice => "Company information was updated successfully"
    else
      render "edit", :notice => "Company information was not updated"
    end
  end
  
  def destroy
    @posts = Post.find(params[:id])
    @posts.destroy
    redirect_to posts_path, :notice => "The information was deleted"
  end
  
 
  
  private
    # Using a private method to encapsulate the permissible parameters is
    # just a good pattern since you'll be able to reuse the same permit
    # list between create and update. Also, you can specialize this method
    # with per-user checking of permissible attributes.
    def posts_params
      params.require(:post).permit(:name, :ticker, :description, :region, :website, :active)
    end
  
  

  helper_method :our_price, :recomendation, :get_data, :trim_namespace, :make_recommendation
end
