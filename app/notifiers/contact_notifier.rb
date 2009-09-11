class ContactNotifier < ActionMailer::Base
  
  def contact_confirmation(name, email, phone, extension, comment)
    recipients APP_CONFIG['support_email']
    from APP_CONFIG['contact_email']
    sent_on Time.now
    subject 'Green Label: Contact Us'
    content_type "text/html"
    body :name => name, :email => email, :phone => phone,
         :extension => extension, :comment => comment
  end 
  
end