module Admin

class OrdersController < ApplicationController
  layout "admin"
  require_role "admin"

  # GET /orders
  # GET /orders.xml
  def index

    if params[:search]
      @orders = Order.find_by_full_name_or_order_number(params[:search]).paginate(:page => params[:page])
    else
      @orders = Order.paginate :page => params[:page],
                               :order => 'id DESC'
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @order.to_xml }
    end
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1;edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.xml
  def create
    @order = Order.new(params[:order])

    respond_to do |format|
      if @order.save
        flash[:notice] = 'Order was successfully created.'
        format.html { redirect_to order_url(@order) }
        format.xml  { head :created, :location => order_url(@order) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @order.errors.to_xml }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.xml
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        flash[:notice] = 'Order was successfully updated.'
        format.html { redirect_to admin_order_url(@order) }
        format.xml  { head :ok }
      else
        format.html { render :action => 'edit', :controller => 'admin/orders' }
        format.xml  { render :xml => @order.errors.to_xml }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.xml  { head :ok }
    end
  end

  def change_delivery_status
    @order = Order.find(params[:order_id])
    @order.delivery_status = params['delivery_status']
    @order.save!

    render :nothing => true
  end
end

end
