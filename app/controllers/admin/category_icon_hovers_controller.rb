class Admin::CategoryIconHoversController < ApplicationController
  layout "admin"
  require_role "admin"
  
  def create 
    category_icon = CategoryIcon.find(params[:category_icon_id])
    category.create_category_icon_hover(params[:category_icon_hover])
    render :partial => '/admin/categories/icon_hover', 
           :locals => { :category_icon_hover => category }
  end
  
  def destroy
    category = Category.find(params[:category_icon_id])
    category_icon = CategoryIcon.find(params[:id])
    category_icon.destroy
    render :partial => '/admin/categories/icon', 
           :locals => { :category => category }
  end   

end
