module Admin
  
class StoresController < ApplicationController
    layout 'admin'
    require_role "admin"
   
    # add an image to a store
    def add_store_image
      image = StoreImage.new(params[:store_image])
      store = Store.find(params[:id])
      store.store_images << image
      if store.save
          responds_to_parent do
            render :update do |page| 
               page[:image_list].replace_html :partial => 'image_list', :locals => { :store => store }
          end
        end
      else 
        flash[:notice] = "image not saved"
        render :action => "new"
      end
    end  
  
    # remove an image from the store
    def remove_store_image
      @store = Store.find(params[:id])
      @image = StoreImage.find(params[:image_id])
      @store.store_images.delete(@image)  
    
      respond_to do |format|
        format.js { 
          render :partial => 'image_list', :locals => { :store => @store }
        }
      end  
    end
  
    # GET /stores
    def index
       @stores = Store.paged_stores(params[:page])

      respond_to do |format|
        format.html # index.rhtml
      end
    end

    # GET /stores/1
    def show
     @store = Store.find(params[:id])
      
      respond_to do |format|
        format.html # show.rhtml
      end
    end

    # GET /regions/new
    def new
      @store = Store.new
    end

    # GET /regions/1;edit
    def edit
      @store = Store.find(params[:id])
    end

    # POST /regions
    def create
      puts params[:store]
      @store = Store.new(params[:store])
      @store = Store.geocode_address(@store)

      respond_to do |format|
        if @store.save
          flash[:store] = 'You have just created a new store'
          format.html { redirect_to admin_stores_url }
        else
          flash[:store] = 'There were errors:'
        end
      end
    end

    # PUT /regions/1
    def update
      @store = Store.find(params[:id])
    
      Store.transaction do
          @store.update_attributes(params[:store]) 
          @store = Store.geocode_address(@store)
          @store.save!
          flash[:notice] = 'store was successfully updated.'
          redirect_to admin_store_url(@store) 
      end
      rescue Exception => err 
           flash[:notice] = err.message
           render :action => "edit" 
      
    end

    # DELETE /regions/1
    def destroy
      @store = Store.find(params[:id])
      @store.destroy
      
      respond_to do |format|
        format.html { redirect_to admin_stores_url }
      end
    end
end

end
