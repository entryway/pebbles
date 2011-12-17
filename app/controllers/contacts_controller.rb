class ContactsController < ApplicationController

  def create
    begin
      ContactNotifier.deliver_contact_confirmation(params[:name], params[:email],
                                                   params[:phone], params[:extension],
                                                   params[:comment])
    rescue
      render :text => 'Sorry there was a problem sending your message. Please try again later'
    end
  end
end