class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['username'], password: ENV['password']
  
  def show
    @prod_total = Product.all.count
    @cat_total = Category.all.count
  end
end
