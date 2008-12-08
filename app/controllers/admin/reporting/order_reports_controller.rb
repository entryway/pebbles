
class Admin::Reporting::OrderReportsController < ApplicationController
  layout 'admin'
  require_role 'admin'
      
  def create
    generate_report = params[:generate_report]
    if generate_report
      session[:start_date] = params[:start_date]
      session[:end_date] = params[:end_date]
      csv = render_order_report_as :csv
      send_data csv, :type => "text/csv",
                     :filename => "orders#{session[:start_date]}.csv"      
    end
  end
  
  def csv_list
    csv = render_order_report_as :csv
    send_data csv, :type => "text/csv",
                   :filename => "orders.csv" 
  end
  
  def pdf
    pdf = render_order_report_as :pdf
    send_data pdf, :type => "application/pdf",
                   :filename => "orders.pdf" 
  end
  
  protected

  def render_order_report_as(format)
    OrderReport.render(format, :start_date => session[:start_date],
                               :end_date => session[:end_date])
  end

end
