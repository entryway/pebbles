
module Admin

class CategoriesController < ApplicationController
  layout "admin"
  require_role "admin"
  
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
  
  # add new category
  # TODO: this should be a POST/REST call, not a separate method?
  def add_category
    @categories = Category.root.all_children
    @category = Category.find(:first)   
    
    category = Category.new(:name => params[:category][:name],  
                            :description => params[:category][:description],
                            :active => params[:category][:active])
    category.save!
    parent = Category.find(params[:parent_category])
    category.move_to_child_of parent
    
    render :nothing => true
  end
  
  # setup to edit selectd category
  def setup_edit_category
    categories = Category.root
    category = Category.find(params[:category_selector])
    
    render :partial => 'edit', :locals => { :categories => categories, :category => category }
  end
  
  # edit submitted category
  def edit_category
    category = Category.find(params[:id])
    category.name = params[:category][:name]
    category.save!
    parent = Category.find(params[:parent_category])
    category.move_to_child_of parent  
	
	categories = Category.root
	
    render :partial => 'edit', :locals => { :categories => categories, :category => category }
  end
  


  # the REST
  
  # GET /categories
  # GET /categories.xml
  def index
    @categories = Category.root.all_children
    
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @categories.to_xml }
    end
  end

  # GET /categories/1
  # GET /categories/1.xml
  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @category.to_xml }
    end
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1;edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.xml
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        flash[:notice] = 'Category was successfully created.'
        format.xml  { head :created, :location => category_url(@category) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @category.errors.to_xml }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.xml
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        flash[:notice] = 'Category was successfully updated.'
        format.html { redirect_to category_url(@category) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @category.errors.to_xml }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.xml
  def destroy
    category = Category.find(params[:id])
    category.destroy
	@categories = Category.root.all_children
	
	render :action => 'index'
  end
end

end
