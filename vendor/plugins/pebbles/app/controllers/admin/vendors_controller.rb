module Admin

class VendorsController < ApplicationController
  layout "admin"
  require_role "admin"
  
  # GET /vendors
  # GET /vendors.xml
  def index
    @vendors = Vendor.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @vendors.to_xml }
    end
  end

  # GET /vendors/1
  # GET /vendors/1.xml
  def show
    @vendor = Vendor.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @vendor.to_xml }
    end
  end

  # GET /vendors/new
  def new
    @vendor = Vendor.new
  end

  # GET /vendors/1;edit
  def edit
    @vendor = Vendor.find(params[:id])
  end

  # POST /vendors
  # POST /vendors.xml
  def create
    @vendor = Vendor.new(params[:vendor])

    respond_to do |format|
      if @vendor.save
        flash[:notice] = 'Vendor was successfully created.'
        format.html { redirect_to admin_vendor_url(@vendor) }
        format.xml  { head :created, :location => admin_vendor_url(@vendor) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @vendor.errors.to_xml }
      end
    end
  end

  # PUT /vendors/1
  # PUT /vendors/1.xml
  def update
    @vendor = Vendor.find(params[:id])

    respond_to do |format|
      if @vendor.update_attributes(params[:vendor])
        flash[:notice] = 'vendor was successfully updated.'
        format.html { redirect_to admin_vendor_url(@vendor) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @vendor.errors.to_xml }
      end
    end
  end

  # DELETE /vendors/1
  # DELETE /vendors/1.xml
  def destroy
    @vendor = Vendor.find(params[:id])
    @vendor.destroy

    respond_to do |format|
      format.html { redirect_to vendors_url }
      format.xml  { head :ok }
    end
  end
end

end
