module Admin
  class CategoriesController < ApplicationController
    layout "admin"
    #  require_role "admin"
    def index
      @categories = Category.root.children
      respond_to do |format|
        format.html # index.rhtml
      end
    end

    def new
      @category = Category.new
    end
    
    def create
      @category = Category.new(params[:category])
      @category.position = Category
      
      respond_to do |format|
        if @category.save

          parent_category = Category.find(params[:category][:parent_id])
          @category.move_to_child_of parent_category

          flash[:notice] = 'Category was successfully created.'
          format.html { redirect_to(@category) }
        else
          format.html { render :action => "new" }
        end
      end
    end
    
    def edit
      @category = Category.find(params[:id])
    end
    
    def update
      @category = Category.find(params[:id])

      respond_to do |format|
        if @category.update_attributes(params[:category])

          parent = Category.find(params[:category][:parent_id])
          @category.move_to_child_of parent

          flash[:notice] = 'Category was successfully updated.'
          format.html { redirect_to(@category) }
        else
          format.html { render :action => "edit" }
        end
      end
    end
    
   def show
      @category = Category.find(params[:id])

      respond_to do |format|
        format.html # show.rhtml
      end
    end


   def destroy
      category = Category.find(params[:id])
      category.destroy
      
      respond_to do |format|
        format.html { redirect_to(categories_url) }
      end
    end
    
    def reorder
      category = Category.find(params[:id])
      category.reorder(params)
      @categories = Category.root.children
      render :partial => 'category_branch', :locals => { :categories => @categories }
    end



  end
end
