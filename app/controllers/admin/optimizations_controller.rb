module Admin

  class OptimizationsController < ApplicationController
    layout "admin"
    require_role "admin"

    def index
      @optimization = Optimization.first || Optimization.create

      respond_to do |format|
        format.html # index.rhtml
        format.xml  { render :xml => @optimization.to_xml }
      end
    end

    def edit
      @optimization = Optimization.first
    end

    def update
      @optimization = Optimization.first
      respond_to do |format|
        if @optimization.update_attributes(params[:optimization])
          flash[:notice] = 'optimization was successfully updated.'
          format.html { redirect_to admin_optimizations_url }
          format.xml  { head :ok }
        else
          puts "failed"
          format.html { render :action => "edit" }
          format.xml  { render :xml => @optimization.errors.to_xml }
        end
      end
    end

  end
end