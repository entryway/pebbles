module Admin

  class ConfigurationsController < ApplicationController
    layout "admin"
    require_role "admin"

    def index
      @configuration = Configuration.first || Configuration.create

      respond_to do |format|
        format.html # index.rhtml
        format.xml  { render :xml => @optimization.to_xml }
      end
    end

    def edit
      @configuration = Configuration.first || Configuration.create
    end

    def update
      @configuration = Configuration.first
      respond_to do |format|
        if @configuration.update_attributes(params[:configuration])
          flash[:notice] = 'configuration was successfully updated.'
          format.html { redirect_to admin_configurations_url }
          format.xml  { head :ok }
        else
          puts "failed"
          format.html { render :action => "edit" }
          format.xml  { render :xml => @configurations.errors.to_xml }
        end
      end
    end

  end
end