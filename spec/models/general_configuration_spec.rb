require File.dirname(__FILE__) + '/../spec_helper'

describe GeneralConfiguration do
  describe ".shipping_calculated_by_weight?" do
    let(:configuration) { GeneralConfiguration.instance }
    it "should return false when shipping method is not weight" do
      configuration
      GeneralConfiguration.shipping_calculated_by_weight?.should be_false
    end

    it "should return false when shipping method is not weight" do
      configuration.update_attribute(:shipping_calculation_method, 'weight')
      GeneralConfiguration.shipping_calculated_by_weight?.should be_true
    end

  end
end