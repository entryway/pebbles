module Admin
  class CategoriesController < ApplicationController
    layout "admin"
    #  require_role "admin"
    
    # add an image to a category
    def add_category_image
      image = CategoryImage.new(params[:category_image])
      category = Category.find(params[:id])
      category.category_images << image
      
      responds_to_parent do
        render :update do |page| 
          page[:image_list].replace_html :partial => 'image_list', :locals => { :category => category }
        end
      end
    end  
    
    # remove an image from the category
    def remove_category_image
      @category = Category.find(params[:id])
      @image = CategoryImage.find(params[:image_id])
      @category.category_images.delete(@image)  
      
      respond_to do |format|
        format.js { 
          render :partial => 'image_list', :locals => { :category => @category }
        }
      end  
    end

    def reorder
      order = params[:category]
      Category.order(order)
      render :text => order.inspect
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
    
    def index
      @categories = Category.find(:all, :order => 'lft ASC')
      
      respond_to do |format|
        format.html # index.rhtml
      end
    end

    def show
      @category = Category.find(params[:id])

      respond_to do |format|
        format.html # show.rhtml
      end
    end

    def new
      @category = Category.new
    end

    def edit
      @category = Category.find(params[:id])
    end

    def destroy
      category = Category.find(params[:id])
      category.destroy
      
      respond_to do |format|
        format.html { redirect_to(categories_url) }
      end
    end



  end
end
