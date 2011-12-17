module Admin


class FlatRateShippingController < ApplicationController
    layout 'admin'
    require_role "admin"

    def index

    end


end

end