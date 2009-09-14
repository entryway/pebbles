module Admin
  
class RegionsController < ApplicationController
    layout 'admin'
    require_role "admin"
  
    # GET /regions
    def index
      @regions = Region.find(:all)

      respond_to do |format|
        format.html # index.rhtml
      end
    end

    # GET /regions/1
    def show
      @region = Region.find(params[:id])
      
      respond_to do |format|
        format.html # show.rhtml
      end
    end

    # GET /regions/new
    def new
      @region = Region.new
    end

    # GET /regions/1;edit
    def edit
      @region = Region.find(params[:id])
    end

    # POST /regions
    def create
      puts params[:region]
      @region = Region.new(params[:region])

      respond_to do |format|
        if @region.save
          flash[:notice] = 'You have just created a new region'
          format.html { redirect_to admin_regions_url }
        else
          flash[:notice] = 'There were errors:'
        end
      end
    end

    # PUT /regions/1
    def update
      @region = Region.find(params[:id])

      respond_to do |format|
        if @region.update_attributes(params[:region])
          flash[:notice] = 'region was successfully updated.'
          format.html { redirect_to admin_regions_url }
        else
          format.html { render :action => "edit" }
        end
      end
    end

    # DELETE /regions/1
    def destroy
      @region = Region.find(params[:id])
      @region.destroy
      
      respond_to do |format|
        format.html { redirect_to admin_regions_url }
      end
    end
end

end
