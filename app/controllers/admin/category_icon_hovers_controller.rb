class Admin::CategoryIconHoversController < ApplicationController
  layout "admin"
  require_role "admin"
  
  def create 
    category_icon = CategoryIcon.find(params[:category_icon_id])
    category_icon.create_category_icon_hover(params[:category_icon_hover])
    render :partial => '/admin/categories/icon_hover', 
           :locals => { :icon => category_icon }
  end
  
  def destroy
    category_icon = CategoryIcon.find(params[:category_icon_id])
    category_icon_hover = CategoryIconHover.find(params[:id])
    category_icon_hover.destroy
    render :partial => '/admin/categories/icon_hover', 
           :locals => { :icon => category_icon }
  end   

end
