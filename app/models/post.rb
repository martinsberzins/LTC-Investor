class Post < ActiveRecord::Base
  has_many :reports

  validates :name, :ticker, :region, :presence => true
  validates :name, :length => {:minimum => 2}
  validates :name, :ticker, :uniqueness => {:message => "already added"}


end
