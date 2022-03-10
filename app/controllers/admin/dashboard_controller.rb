class Admin::DashboardController < ApplicationController
  def show
    @products_count = Product.all.count.to_s
    @categories_count = Category.all.count.to_s
  end
end
