class OrderNotifier < ActionMailer::Base
  
  def order_confirmation(order, email, ip)
    recipients "#{email}"
    from APP_CONFIG['order_email']
    sent_on Time.now
    subject APP_CONFIG['order_subject']
    content_type "text/html"
    body :order => order, :ip => ip, :site_address => APP_CONFIG['site_address']
  end 
  
  # send an email to the supplier of goods
  def supplier_confirmation(order, customer, ip)
    recipients APP_CONFIG['order_email']
    from APP_CONFIG['order_email']
    # enable replying to the customer 
    reply_to customer
    sent_on Time.now
    subject APP_CONFIG['order_subject']
    content_type "text/html"
    body :order => order, :ip => ip, :site_address => APP_CONFIG['site_address']
  end
end