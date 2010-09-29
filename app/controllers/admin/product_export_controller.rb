class Admin::ProductExportController < ApplicationController
  def show
    send_data Exporter.export_products, :filename => 'products.csv'
  end
end
