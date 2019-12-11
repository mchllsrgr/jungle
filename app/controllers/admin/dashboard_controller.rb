class Admin::DashboardController < ApplicationController
  def show
    @prod_total = Product.all.count
    @cat_total = Category.all.count
  end
end
