class AddPostRefToReports < ActiveRecord::Migration
  def change
    add_reference :reports, :post, index: true
  end
end
