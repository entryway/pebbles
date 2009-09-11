Address.create(:address_1   => '123 test lane', 
               :address_2   => 'continued address',
               :city        => 'douglas',
               :postal_code => '32342',
               :is_shipping => true,
               :country     => 'united states',
               :state       => 'wy')

Category.create(:name     => 'hats',
                :position => 1,
                :description => 'things you put on your head')

Product.create(:name => 'test',
               :sku  => '2342342')
User.create(:login => 'admin', 
            :password => 'admin',
            :email => 'dev@entryway.net',
            :password_confirmation => 'admin',
            :role => 'admin'
            )
