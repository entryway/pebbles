module Wholesaler

  def verify_wholesaler
    @is_wholesaler = false
       unless session[:wholesaler] == nil
         @is_wholesaler = true
       end
    @is_wholesaler
  end

  def download_file
    send_file("public/TestingDownload.txt", :disposition => "attachment")
  end


end