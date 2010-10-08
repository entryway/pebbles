module Admin

  class OrderItemsController < ApplicationController
    layout "admin"
    require_role "admin"

    def index
      respond_to do |wants|
        wants.csv do
          order_items_report = OrderItem.report_table(:all, :only => [],
                              :include => { :product => { :only => [:sku, :name],
                                              :include => {:categories => {:only => [:name]}}},
                                            :order => { :only => [:full_name, :phone_number],
                                            :include => {:shipping_address => {
                                            :only => [:address_1, :address_2, :city,
                                            :postal_code, :state, :country]}}}})
          csv = order_items_report.to_csv
          send_data csv, :type => 'text/csv',
                         :filename => "orders_#{Date.today.to_s}.csv"
        end
      end
    end

    def update
      order_item = OrderItem.find(params[:id])
      quantity = params[:quantity].to_i
      unless quantity < 0
        if order_item.quantity != quantity
          order_item.quantity = quantity
          order_item.save!
        end
      end
      @order = order_item.order
      @order.calculate_order_costs
      @order.save!
    end

    def destroy
      order_item = OrderItem.find(params[:id])
      @order = order_item.order
      order_item.destroy
      @order.calculate_order_costs
      @order.save!
    end
  end



end
