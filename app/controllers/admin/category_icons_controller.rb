class Admin::CategoryIconsController < ApplicationController
  layout "admin"
  require_role "admin"

  def create
    category = Category.find(params[:category_id])
    category.create_category_icon(params[:category_icon])

    render :partial => '/admin/categories/icon',
           :locals => { :category => category }
  end

  def destroy
    category = Category.find(params[:category_id])
    category_icon = CategoryIcon.find(params[:id])
    category_icon.destroy
    render :partial => '/admin/categories/icon',
           :locals => { :category => category }
  end

end
